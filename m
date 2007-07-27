Return-Path: <rutger@wingding.demon.nl>
Received: from post-23.mail.nl.demon.net (post-23.mail.nl.demon.net
	[194.159.73.193]) by ozlabs.org (Postfix) with ESMTP id C08B6DDE18
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jul 2007 08:11:37 +1000 (EST)
Date: Sat, 28 Jul 2007 00:11:31 +0200
From: Rutger Nijlunsing <rutger@nospam.com>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH] Re: 2.6.22-git hangs during PCMCIA on PowerBook G3 in
	0.0 seconds
Message-ID: <20070727221131.GA18273@nospam.com>
References: <20070721192143.GA12144@nospam.com>
	<20070721212845.GA30977@nospam.com>
	<20070723172725.b1c14885.kim.phillips@freescale.com>
	<1185234923.5439.158.camel@localhost.localdomain>
	<20070724185946.722f34b5.kim.phillips@freescale.com>
	<18088.6185.491082.875891@cargo.ozlabs.ibm.com>
	<20070726162921.a60c76ae.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070726162921.a60c76ae.kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: linuxppc-dev@tux.tmfweb.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Kim
> 
> p.s. should the stable team be notified to fix 2.6.22 for
> Lombard-nvram-style machines?

Logically, yes. 

Practically it does not matter that much it seems. I've got the
feeling the Lombard-users-group-size is about one person which is
going to drop to zero if he doesn't get any further in being able to
use _any_ PCMCIA card in his machine ;-)

For example, PCMCIA (non-cardbus) does not work on Lombard since
~2.6.12 (2 years old bug instantly crashing the kernel!) according to
own experiences, Google and own git-bisecting down to 2.6.13,
compiling and running different kernels. 2.6.12 appears to require the
'old-style' PCMCIA tools, which I do not have installed and is
therefore impossible for me to test.

Links:
  2.6.12 works with PCMCIA on Lombard:
    http://www.mascanc.net/~vieri/gnumela.html
  2.6.13 dead
    (checked with git)
  2.6.15 dead (Lombard PCMCIA problems in FC5):
    http://forums.fedoraforum.org/archive/index.php/t-110657.html
  2.6.18 dead, 2.6.12 works:
    http://lists.infradead.org/pipermail/linux-pcmcia/2006-October/004051.html
  2.6.19 dead (own bug report):
    http://ozlabs.org/pipermail/linuxppc-dev/2006-November/028617.html
  2.6.20 dead:
    http://lists.infradead.org/pipermail/linux-pcmcia/2007-April/004500.html
  2.6.22 dead (own bug report #2):
    http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039863.html

The initial reason to bisect to the now-reverting patch was to get a
working Lombard. I'd like to get this working or to help out in any
way, but I don't know how to proceed...

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
