Message-ID: <3975120E.BF786A90@execpc.com>
Date: Tue, 18 Jul 2000 21:27:26 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: cl.en@gmx.net, Stephan Leemburg <pmud-bugs@jvc.nl>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: preliminary 3400 APM support for PMUD - bugfix
References: <3973D3E6.578C8B5C@execpc.com> <20000719010522.A542@olis.north.de> <3974E8F9.BFC337E6@execpc.com> <20000719030735.A445@olis.north.de>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


small bug fix.  i checked, and it seems I need to multiply the timeleft on line
685 by 60.

Thanks to Claus Enneper for helping catch that.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
