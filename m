Content-Type: text/plain;
  charset="iso-8859-1"
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: PMU panic in 2.4bk
Date: Mon, 29 Jan 2001 16:55:20 -0600
MIME-Version: 1.0
Message-Id: <01012916552001.05635@momiji>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been recently getting a PMU panic using an unmodified 2.4 kernel from
the bitkeeper rsync.  Looking in via-pmu.c, the issues appears to be known as
a potential problem, and I think I have found that it is.

Symptoms:  upon heavy access to video (fb console or ati/XF4) like scrolling
or netscape full screen, or heavy access to the hard drive (fsck or huge
copy), I get 'LCD fire' (melting as some call it).  On once instance, the
system just powered off after a brief burn/melt.   I know this is what
happens when the PMU is ignored for too long.

System: standard WallstreetII(PDQ) 300MHz, 384M RAM,  IBM 30G drive (4200rpm
type)

Anyone know more about this or how it might be fixed?

Thanks.

--
Joseph P. Garcia
http://www.execpc.com/~jpgarcia

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
