Message-ID: <3ADC75CF.6E15C79F@mvista.com>
Date: Tue, 17 Apr 2001 09:56:47 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Alan Wang <wung_y@sina.com>
Cc: Linuxppc-EmbeddedMaillist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: how to configure LCD as console for RPX-LITE
References: <EBEGJCKFJMJLDPEKGAKJKEBNCAAA.wung_y@sina.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I don't remember 2.2.13 having a framebuffer driver for the lcd.
download the 2.2.14 kernel from ftp.mvista.com

we have pre-configured/built kernel rpms for the rpx-lite called lsp's
(linux support package).  those are a good starting point for
configuring for a frame buffer.  As for the console part, I have never
tried but it should work.

Alan Wang wrote:
>
> Hi, all
>   I am compiling mpc8xx-2.2.13 for my RPX-LITE(mpc823) board. Now, I want to use the LCD
> as my console but when I enable the frame buffer and virtual terminal by "make configure", I got
> so many "reference undefined" errors when linking. is there anybody succeeded in this?
> how do u configure your kernel? thank you.
>
> Alan
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
