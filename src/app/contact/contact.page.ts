import { Component } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-contact',
  templateUrl: './contact.page.html',
  styleUrls: ['./contact.page.scss'],
  standalone: true,
  imports: [IonicModule, CommonModule, FormsModule]
})
export class ContactPage {
  formData = {
    name: '',
    email: '',
    message: ''
  };

  constructor() {}

  submitForm() {
    // For now, just open email client with pre-filled content
    const subject = encodeURIComponent('Contact from kablerecord.com');
    const body = encodeURIComponent(`Name: ${this.formData.name}\nEmail: ${this.formData.email}\n\nMessage:\n${this.formData.message}`);
    window.location.href = `mailto:kablerecord@gmail.com?subject=${subject}&body=${body}`;
  }
}
