import { AppTesteService } from './app-teste.service';
import { ProAppConfigService, ProJsToAdvplService } from 'protheus-lib-core';
import { Component, OnInit, ViewChild } from '@angular/core';
import { finalize } from 'rxjs/operators';
import {
  PoBreadcrumb,
  PoChartOptions,
  PoChartSerie,
  PoChartType,
  PoDynamicViewField,
  PoMenuItem,
  PoModalComponent,
} from '@po-ui/ng-components';
import {
  PoPageDynamicTableActions,
  PoPageDynamicTableCustomAction,
  PoPageDynamicTableCustomTableAction,
  PoPageDynamicTableOptions,
} from '@po-ui/ng-templates';
import { SamplePoPageDynamicTableUsersService } from './SamplePoPageDynamicTableUsers.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
})
export class AppComponent implements OnInit {
  @ViewChild('userDetailModal') userDetailModal: PoModalComponent;
  @ViewChild('dependentsModal') dependentsModal: PoModalComponent;
  @ViewChild('chartModal') chartModal: PoModalComponent;

  ngOnInit():void{

  }
}
