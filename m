Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (unknown
 [IPv6:2001:470:b8bc:cafe:5054:ff:fedc:793f])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 05CF1B7032
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2012 06:52:12 +1000 (EST)
To: Scott Wood <scottwood@freescale.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
From: Anthony Foiani <tkil@scrye.com>
References: <ghave7n25.fsf@dworkin.scrye.com>
 <94F013E7935FF44C83EBE7784D62AD3F0930B855@039-SN2MPN1-022.039d.mgd.msft.net>
 <g7gvzbfhb.fsf@dworkin.scrye.com> <4FC50F22.2040404@freescale.com>
 <gvcjetze3.fsf@dworkin.scrye.com> <4FC5546A.4090506@freescale.com>
 <gd35lbf55.fsf@dworkin.scrye.com> <4FC68109.3030607@freescale.com>
Date: Wed, 30 May 2012 14:52:09 -0600
In-Reply-To: <4FC68109.3030607@freescale.com> (Scott Wood's message of "Wed,
 30 May 2012 15:20:25 -0500")
Message-ID: <g8vg9bddy.fsf@dworkin.scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>, Jeff Garzik <jeff@garzik.org>,
 Adrian Bunk <bunk@stusta.de>
Reply-To: Anthony Foiani <tkil@scrye.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> writes:

> We currently support building one kernel that supports a bunch of
> different boards.  The hardcoding of this workaround was harmless so
> far because it was conditional on a symbol that was never defined,
> but now you'll be enabling this workaround on any kernel that simply
> has support for mpc8315erdb.  That is not acceptable unless you show
> it's harmless on all those other boards.

Ok, I see your point now.  Sorry for being dense.

At the moment, I'm building a kernel that is only going to run on this
particular board, so the kconfig solution works *for me*.

Unfortunately, I'm not sure I can help develop a more generic
solution.  I can't reliably reproduce the problem, so I can't even
offer to help test for it.

Even more unfortunately, I don't currently have the bandwidth to do
any more investigation or experimenting with the devtree option (as
much as I would like to!).  At this point in my project, I probably
can't even justify trying to switch to a more current kernel, so I
couldn't try out a new release regardless.

Sorry I can't be more help.

Thanks again,
Tony
