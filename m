Reply-To: <ldu@solectek.com>
From: "Leiying Du" <ldu@solectek.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: "'LinuxPPC-Embedded'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Ramdisk with wrong magic number 
Date: Fri, 31 Jan 2003 12:20:12 -0800
Message-ID: <DDEMKFCKCAHJDIFEOONBGEGMCAAA.ldu@solectek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <20030131201258.04531C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks, James and Wolfgang. I forgot to use the mkimage to convert it.

All the best,

Leiying

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Wolfgang
Denk
Sent: Friday, January 31, 2003 12:13 PM
To: ldu@solectek.com
Cc: 'LinuxPPC-Embedded'
Subject: Re: Ramdisk with wrong magic number



In message <DDEMKFCKCAHJDIFEOONBOEGLCAAA.ldu@solectek.com> you wrote:
>
>    I downloaded your mini ramdisk. The file name is
> mini-2048kB-ramdisk.image.gz. If I check the image that I wrote into the
> flash, I will get an wrong magic number error. Do you konw what's wrong
with
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
