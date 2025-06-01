<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Str;

class BulkEmailMailable extends Mailable
{
    use Queueable, SerializesModels;

    public $subjectText;
    public $bodyMessage;
    public $settingData;

    public function __construct($subjectText, $bodyMessage, $settingData)
    {
        $this->subjectText = $subjectText;
        $this->bodyMessage = $bodyMessage;
        $this->settingData = $settingData;
    }

    public function envelope(): Envelope
    {
        return new Envelope(
            subject: $this->subjectText
        );
    }

    public function content(): Content
    {
        return new Content(
            view: 'emails.bulk_email',
            with: [
                'subjectText' => $this->subjectText,
               'bodyMessage' => nl2br(e(
    Str::of($this->bodyMessage)
        ->replace(['<p>', '<br>', '<br/>', '<br />'], "\n")
        ->replace(['</p>'], "\n")
        ->stripTags()
        ->replace('&nbsp;', ' ')
        ->trim()
)),
                'settingData' => $this->settingData,

            ],
        );
    }
}
