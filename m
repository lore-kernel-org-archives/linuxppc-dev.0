To: Shamile Khan <shamile@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8-bit mtd flash support 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 19 Jan 2004 17:13:32 PST."
             <20040120011332.12136.qmail@web11601.mail.yahoo.com>
Date: Tue, 20 Jan 2004 09:31:17 +0100
Message-Id: <20040120083122.A5684C0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040120011332.12136.qmail@web11601.mail.yahoo.com> you wrote:
>
> I am faced with a situation where my processor is connected
> to 1 NOR flash chip in 8-bit mode. Now the consequence of
> this is that I cannot excute code directly from flash. I am

Why not? You should be able to configure your processor to use a  bus
width of 8 bit for the flash device.

> I was wondering if
> a) Its a valid concept to have a Linux mtd flash filesystem
> where the flash chip only allows 8-bit access

Yes.

> b) anyone else has been in this situation and

Yes.

> c) if there are mtd drivers available for 8-bit access to a
> flash chip.

Yes.

All this is in place and working.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The following statement is not true.  The previous statement is true.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
