import { Component } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-book',
  templateUrl: './book.page.html',
  styleUrls: ['./book.page.scss'],
  standalone: true,
  imports: [IonicModule, CommonModule]
})
export class BookPage {
  constructor() {}
}
