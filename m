Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id CF1A267A67
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  6 Mar 2005 09:51:29 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Sat, 5 Mar 2005 15:51:28 -0700
To: Sven Luther <sven.luther@wanadoo.fr>
Message-ID: <20050305225128.GC16904@xyzzy>
References: <41F6E0E1.6000803@mvista.com> <20050224082508.GA30005@pegasos>
	<421DF2B8.6040007@mvista.com> <20050224160411.GA11197@pegasos>
	<20050224172420.GA6932@xyzzy> <20050305192752.GA28491@pegasos>
	<20050305203254.GB30151@pegasos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050305203254.GB30151@pegasos>
Cc: Nicolas DET <det.nicolas@free.fr>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] mv64x60 updates
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Mar 05, 2005 at 09:32:54PM +0100, Sven Luther wrote:
> On Sat, Mar 05, 2005 at 08:27:52PM +0100, Sven Luther wrote:
> > On Thu, Feb 24, 2005 at 10:24:20AM -0700, Dale Farnsworth wrote:
> > > See bk://dfarnsworth.bkbits.net/linux-2.5-mv643xx-enet
> > 
> > I guess i need to look there, as in mainline 2.6.11, there doesn't seem to be
> > direct related code between the ppc specific mv64x60 stuff, and the mips
> > related ethernet one.
> 
> Ok, i think that did it, and i have a 200kb diff against 2.6.11 :) Many of
> those are just 64340-> 643xx replacements though.

Yes, renames and Lindent make for big diffs.

> What are your plans for mainline inclusion of the rest of those, and is it ok

I've submitted it for mainline inclusion.  Jeff Garzik put it in
netdev-2.6 (and thus in the mm patches) for testing and it's on track
for going into mainline.  I hope it will happen in the next few days,
but that's up to Jeff.

> to work directly with your stuff ? Do you have any experimental or dangerous
> parts in the above ? And did you ever get the gigabit ethernet port working on
> a powerpc board ? Or are there some Kconfig parts i have missed ?

By all means, try it.  Several people are using it without complaints, but
I'd appreciate your feedback.  There isn't anything dangerous in there.
Gigabit works for me.  I'm not sure what Kconfig parts would be needed
specifically for gigabit support.

Updates are coming though.  James Chapman has sent me several patches
that provide: use of the mii library for phy management, additional
ethtool support, message level support, compile fix for non-NAPI, and
much cleanup.  We're working the kinks out now and I expect to submit
these patches in the next few days.

Thanks,
-Dale
