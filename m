Date: Fri, 11 Jun 2004 14:44:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Chris Clark <linuxppc-embedded@2nerds.com>
Cc: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Relationship between bk libuxppc-2.4 and denx linuxppc_2_4_devel
Message-ID: <20040611214417.GC925@smtp.west.cox.net>
References: <20040611073059.D13E8C109F@atlas.denx.de> <Pine.GSO.4.53.0406111437580.9184@solaris.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.53.0406111437580.9184@solaris.xmission.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 11, 2004 at 02:59:48PM -0600, Chris Clark wrote:

>
> On Fri, 11 Jun 2004, Wolfgang Denk wrote:
> > You should work with  the  official  trees,  i.  e.  linuxppc-2.4  or
> > linuxppc-2.5.
>
> Unless I made some mistake in cloning the linuxppc-2.{4,5} trees from
> ppc.bkbits.net, (which is entirely possible as I'm a BK newbie), there
> appears to be a fair amount of processor- and platform-specific stuff
> in the Denx linuxppc_2_4_devel CVS tree which does not appear in the
> ppc.bkbits.net BK trees (e.g. arch/ppc/5xxx_io/... ).
>
> Is the Denx CVS tree "authoritative" with regard to those extras?  Is
> there any expectation that those bits found only in the Denx CVS tree
> will eventually find their way into the ppc.bkbits.net tree(s)?  (Or
> some other, more appropriate tree(s)?  If so, which?)

For 2.4?  Denx will probably be the "authoritative" tree.  For 2.6 I am
hopeful that something can be worked out.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
