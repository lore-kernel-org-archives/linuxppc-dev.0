To: Jeff Stevens Stevens <jsteve17@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems with EP862 and ELDK 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 08 Sep 2003 07:59:48 PDT."
             <20030908145948.75210.qmail@web41410.mail.yahoo.com>
Date: Mon, 08 Sep 2003 17:31:47 +0200
Message-Id: <20030908153152.80FF3C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030908145948.75210.qmail@web41410.mail.yahoo.com> you wrote:
>
> Does anyone have PPCBoot and ELDK up an running on an
> EP862 board?
>
> I have PPCBoot working with SDRAM and Flash, but when

Please note that PPCBoot is a dead  project.  You  are  wasting  your
time. Please use the successor project U-Boot instead.

> I compile it to read the environment variables from
> the EEPROM, it won't boot.  Does anyone have this
> working?

Works fine on many boards.

> I can however get it to boot if I compile it to get
> its environment variables from flash (it just
> complains and then loads some defaults).  However,
> when I TFTP ELDK over to the EP862 and "GO 00400000",
> it complains.

As it should. "go" is not the command used to  boot  a  Linux  kernel
image.

> What is the proper way to create the zImage for
> PPCBoot (U-Boot)?

It's a two-step procedure.

The first step is reading the documentation,  i.  e.  especially  the
README and then the DULG - see
http://www.denx.de/twiki/bin/view/DULG/Manual

The second step is using "make uImage" in you kernel tree  (or  "make
pImage" if the new alias is still not there).


Finally, please note that this is off topic here.  Please  send  such
requests to the u-boot-users mailing list instead.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I am a computer. I am dumber than any human and smarter than any  ad-
ministrator.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
