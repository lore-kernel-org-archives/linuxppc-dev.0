To: ldu@solectek.com
Cc: "'LinuxPPC-Embedded'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Ramdisk with wrong magic number 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 30 Jan 2003 19:39:00 PST."
             <DDEMKFCKCAHJDIFEOONBOEGLCAAA.ldu@solectek.com>
Date: Fri, 31 Jan 2003 21:12:53 +0100
Message-Id: <20030131201258.04531C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <DDEMKFCKCAHJDIFEOONBOEGLCAAA.ldu@solectek.com> you wrote:
>
>    I downloaded your mini ramdisk. The file name is
> mini-2048kB-ramdisk.image.gz. If I check the image that I wrote into the
> flash, I will get an wrong magic number error. Do you konw what's wrong with
> this? Thanks.

How do you "check" it? If this is by any chance  under  U-Boot,  then
you  should  read  the docs how to convert a plain ramdisk image like
the one you are using into a U-Boot  image  (hint:  use  the  mkimage
tool).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I paid too much for it, but its worth it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
