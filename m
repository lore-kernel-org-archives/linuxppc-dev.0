Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 11 Jun 2004 14:59:48 -0600 (MDT)
From: Chris Clark <linuxppc-embedded@2nerds.com>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040611073059.D13E8C109F@atlas.denx.de>
Message-ID: <Pine.GSO.4.53.0406111437580.9184@solaris.xmission.com>
References: <20040611073059.D13E8C109F@atlas.denx.de>
MIME-Version: 1.0
Subject: Re: Relationship between bk libuxppc-2.4 and denx linuxppc_2_4_devel
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 11 Jun 2004, Wolfgang Denk wrote:
> You should work with  the  official  trees,  i.  e.  linuxppc-2.4  or
> linuxppc-2.5.

Unless I made some mistake in cloning the linuxppc-2.{4,5} trees from
ppc.bkbits.net, (which is entirely possible as I'm a BK newbie), there
appears to be a fair amount of processor- and platform-specific stuff
in the Denx linuxppc_2_4_devel CVS tree which does not appear in the
ppc.bkbits.net BK trees (e.g. arch/ppc/5xxx_io/... ).

Is the Denx CVS tree "authoritative" with regard to those extras?  Is
there any expectation that those bits found only in the Denx CVS tree
will eventually find their way into the ppc.bkbits.net tree(s)?  (Or
some other, more appropriate tree(s)?  If so, which?)

Thanks,
Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
