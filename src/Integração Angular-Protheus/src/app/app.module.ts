import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { PoFieldModule, PoModalModule, PoModule, PoNotificationModule, PoPageDefaultComponent, PoPageModule, PoTableModule } from '@po-ui/ng-components';
import { PoPageDynamicSearchModule, PoPageDynamicTableModule, PoTemplatesModule } from '@po-ui/ng-templates';
import { RouterModule } from '@angular/router';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgModule } from '@angular/core';
import { ProtheusLibCoreModule } from 'protheus-lib-core';

@NgModule({
  declarations: [
    AppComponent,
  ],
  imports: [
    BrowserModule,
    PoModule,
    PoTemplatesModule,
    RouterModule,
    FormsModule,
    ReactiveFormsModule,
    PoPageModule,
    PoFieldModule,
    PoTableModule,
    PoPageDynamicSearchModule,
    PoPageDynamicTableModule,
    PoModalModule,
    PoNotificationModule,
    // ProtheusLibCoreModule,
    RouterModule.forRoot([])
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
