Message-ID: <39755D95.121F876F@jvc.nl>
Date: Wed, 19 Jul 2000 09:49:42 +0200
From: Stephan Leemburg <sleemburg@jvc.nl>
Reply-To: sleemburg@jvc.nl
MIME-Version: 1.0
To: Joseph Garcia <jpgarcia@execpc.com>
CC: cl.en@gmx.net, Stephan Leemburg <pmud-bugs@jvc.nl>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: preliminary 3400 APM support for PMUD - bugfix
References: <3973D3E6.578C8B5C@execpc.com> <20000719010522.A542@olis.north.de> <3974E8F9.BFC337E6@execpc.com> <20000719030735.A445@olis.north.de> <3975120E.BF786A90@execpc.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OK, I will incorporate all soon, thanks!

Joseph Garcia wrote:
>
> small bug fix.  i checked, and it seems I need to multiply the timeleft on line
> 685 by 60.
>
> Thanks to Claus Enneper for helping catch that.
>
> --
> Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
> CS Undergraduate                      Student Employee - Systems Programmer
> University of Wisconsin - Madison                            UW Lidar Group

--
Stephan Leemburg
JVC Nederland BV
De Heyderweg 2, 2314 XZ  LEIDEN
The Netherlands
phone: +31 (71) 5453310
fax:   +31 (71) 5453436

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
