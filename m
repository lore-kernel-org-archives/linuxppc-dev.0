Date: Fri, 19 Oct 2001 21:25:34 -0500
From: Takashi Oe <toe@unlserve.unl.edu>
To: "David A. Gatwood" <dgatwood@apple.com>
Cc: apm@MIT.EDU, linuxppc-dev@lists.linuxppc.org
Subject: Re: Compiling BootX?
Message-Id: <20011019212534.00c034b5.toe@unlserve.unl.edu>
In-Reply-To: <ED9543FC-C3EC-11D5-951D-003065B90BBC@apple.com>
References: <Pine.GSO.4.30L.0110172159300.16073-100000@biohazard-cafe.mit.edu>
	<ED9543FC-C3EC-11D5-951D-003065B90BBC@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 18 Oct 2001 10:24:04 -0700, David A. Gatwood wrote:

> I missed your hardware config.  What was it, again?  If it's a 68k mac
> with a PPC card, you probably want to set it to the gestalt of a 5300.
> The kernel should then identify that it isn't really a 5300 and should
> half-heartedly attempt to boot anyway, then crash at some point.  Let me
> know the gestalt, and I can verify whether the MkLinux booter knows it.
> I can't promise that I'd be allowed to send you an update or anything,
> but at least I can check and see if it knows the gestalt.  :-)

Could you possibly add the following machines as well?

Gestalt		Models
PPC (na)
104 (89)	Macintosh LC 475/605
105 (92)	Macintosh LC 575
107 (99)	Macintosh LC 580
119 (52)	Centris 610
121 (53)	Quadra 610
106 (98)	Macintosh LC/Quadra 630
120 (30)	Centris 650
122 (36)	Quadra 650
116 (22)	Quadra 700
123 (35)	Quadra 800
117 (20)	Quadra 900
118 (26)	Quadra 950

The numbers in the left-most column are the gestalt id for
LC/Centris/Quadras with ppc upgrade cards I could find at
www.apple.com.


Takashi Oe

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
