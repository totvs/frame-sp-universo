import { TestBed } from '@angular/core/testing';

import { AppTesteService } from './app-teste.service';

describe('AppTesteService', () => {
  let service: AppTesteService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(AppTesteService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
