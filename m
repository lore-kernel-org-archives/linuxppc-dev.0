To: Fillod Stephane <stephane.fillod@thomson.net>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross compiling : problem linking 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 02 Oct 2003 18:34:19 +0200."
             <2C1BAF8F8E1DD611862B0002A5D4C3FC01BC068F@renexch3.rennes.thmulti.com>
Date: Thu, 02 Oct 2003 23:26:40 +0200
Message-Id: <20031002212645.2FC78C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Stephane,

in message <2C1BAF8F8E1DD611862B0002A5D4C3FC01BC068F@renexch3.rennes.thmulti.com> you wrote:
>
> Wolfgang, you've got my agreement to put the following in the FAQ
> if it's not already.

AFAIK it's not.

> This code is for accessing hardware registers from *userland*.
> You need CAP_SYS_RAWIO and /dev/mem permissions.

Thanks!

Or do you want to add it yourself? All you have to do is  registering
at  http://www.denx.de/twiki/bin/view/TWiki/TWikiRegistration ...

Then you can edit / add to the U-Boot and Linux Guide at
http://www.denx.de/twiki/bin/view/DULG/WebHome yourself...


Hint: _anybody_ is welcome to contribute.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Never worry about theory as long as  the  machinery  does  what  it's
supposed to do.                                      - R. A. Heinlein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
