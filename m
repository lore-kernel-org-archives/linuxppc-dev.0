Message-ID: <377B41A6.754DEF58@mpifr-bonn.mpg.de>
Date: Thu, 01 Jul 1999 12:23:34 +0200
From: Albrecht =?iso-8859-1?Q?Dre=DF?= <ad@MPIfR-Bonn.MPG.de>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl@munich.netsurf.de>
CC: LinuxPPC Users <linuxppc-user@lists.linuxppc.org>,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: LinuxPPC & gcc optimizer flags
References: <4.2.0.58.19990701115628.0377f1f0@mail.lauterbach.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:
> Which compiler did you use? Up to egcs-1.1.2, -mcpu=750 is a no-op :-). Did

egcs 1.1.2.  This explains the identical results of no cpu and '750 flags...

> you also try different mixings of -march= and -mtune=?

`arch´ doesn't work at all.  Didn't check tune yet...

> If you are on R5, I can provide you gcc-2.95pre RPM's which support -mcpu=750.

Thanks, but speed is a less critical issue for us than reliability, so I live
with cpu=603 and wait for the final release....

Thanks, Albrecht.

-- 
+-----------------------------------------------------------------------------+
| Dr.-Ing. Albrecht Dre\ss                                     ----           |
| Max-Planck-Institut f\"ur Radioastronomie   |\       /      /o  o\          |
| Abteilung f\"ur Infrarot-Interferometrie    |  \    /      |  /   |         |
| Auf dem H\"ugel 69                          |    \ |        \ ---/          |
| D-53121 Bonn (Germany)          ------------+------+-------------------     |
|                                             |    / |                        |
| Phone (+49) 228 525 319                     |  /  /                         |
| Fax   (+49) 228 525 411                     |/   /                          |
| Mail  ad@mpifr-bonn.mpg.de                                                  |
+-------------- electrical engineers do it with less resistance --------------+

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
