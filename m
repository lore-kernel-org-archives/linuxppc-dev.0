To: "Flavio Pereira" <Flavio.Pereira@za.flextronics.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: System crash in kernel_thread 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 03 Jun 2003 10:36:22 +0200."
             <742AC4678EF8464697DDDFE3B40F6ECD07E2CD@srv-mailrnd.azisa.co.za>
Date: Tue, 03 Jun 2003 12:00:10 +0200
Message-Id: <20030603100015.5C92BC5492@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Flavio,

in message <742AC4678EF8464697DDDFE3B40F6ECD07E2CD@srv-mailrnd.azisa.co.za> you wrote:
>
> I'm trying to port Linux to a proprietary board. I got u-boot working
> good, and now that I start the kernel I find that the system _halts_
> when it tries to run init using the kernel_thread routine in
> init/main.c/rest_init(). Can someone suggest why this could be
> happening?

One pretty common reason is that your SDRAM  initialization  sequence
may be buggy and/or incomplete, and you experience memory errors. Re-
member that more is required than just adapting the UPM tables.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
In the beginning there was nothing.
And the Lord said "Let There Be Light!"
And still there was nothing, but at least now you could see it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
