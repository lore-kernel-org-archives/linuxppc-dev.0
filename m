Message-ID: <3784BDFA.B302AEA7@mpifr-bonn.mpg.de>
Date: Thu, 08 Jul 1999 17:04:26 +0200
From: Albrecht Dreﬂ <ad@MPIfR-Bonn.MPG.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-user@lists.linuxppc.org,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>,
        Linux/Powermac <linux-pmac@samba.anu.edu.au>
Subject: Re: linux-pmac 2.2.10: media bay panics on PBG3
References: <19990708145705.014415@mail.mipsys.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> 
> On Thu, Jul 8, 1999, Albrecht Dreﬂ <ad@MPIfR-Bonn.MPG.de> wrote:
> 
> > >Kernel panic: kernel access of bad area pc c00e7d9c lr c00e7c9c address
> > >F5021070
> 
> This pointer looks weird !
> 
> mac-io controllers are usually at F3xxxxxx or F4xxxxxx (left bay), I
> don't think F5xxxxxx is a correct value.

OK, here's some more strange information:

o compiling linux-pmac-2.2.10 from ftp.linuxppc.org (in user/paulus), i get
  crashes upon inserting the cd drive into the media bay, but the nfs server
  stuff works;

o compiling linux-2.2.10 from kernel.org WITH EXACTLY THE SAME .config, the
  media bay works fine, but the nfs server dies with the nfssrv error.

?????????Where are the inconsistencies???????

Albrecht.

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
