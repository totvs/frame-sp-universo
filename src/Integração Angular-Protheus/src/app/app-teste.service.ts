import { ProJsToAdvplService } from 'protheus-lib-core';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class AppTesteService {
  constructor(private proJsToAdvplService: ProJsToAdvplService) {}

  getConpad(alias: string, campo: string): Observable<any> {
    const jsonEnvio = {
      alias: alias,
      campo: campo,
    };
    return this.proJsToAdvplService.buildObservable<string>(
      ({ protheusResponse, subscriber }: any) => {
        subscriber.next(protheusResponse);
        subscriber.complete();
      },
      {
        autoDestruct: true,
        receiveId: 'retCompad',
        sendInfo: {
          type: 'conpad',
          content: JSON.stringify(jsonEnvio),
        },
      }
    );
  }
}
