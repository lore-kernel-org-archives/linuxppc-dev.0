Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3BF0EDDED1
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 02:26:39 +1100 (EST)
Date: Thu, 17 Jan 2008 18:34:55 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Patches added to master/for-2.6.25 branch of powerpc.git
Message-ID: <20080117153455.GA21766@localhost.localdomain>
References: <18318.56299.476711.644917@cargo.ozlabs.ibm.com>
	<20080117145903.GA4535@localhost.localdomain>
	<A1DA2145-E5AE-4A7D-83D4-D86F05A9F6DF@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <A1DA2145-E5AE-4A7D-83D4-D86F05A9F6DF@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 17, 2008 at 09:11:00AM -0600, Kumar Gala wrote:
> 
> On Jan 17, 2008, at 8:59 AM, Anton Vorontsov wrote:
> 
> >Hello Paul, Kumar,
> >
> >On Thu, Jan 17, 2008 at 03:39:07PM +1100, Paul Mackerras wrote:
> >>Includes commits pulled from Josh Boyer's tree.
> >
> >Um.. Probably I'm being importunate.. if so, just command me to sit
> >silent and wait. ;-) But how about these down here? Ones that touches
> >drivers/net/ are having "Acked-by: Jeff Garzik <jeff@garzik.org>"
> >thus meant to go through one of powerpc tree. Not sure through which
> >one exactly.
> >
> >http://ozlabs.org/pipermail/linuxppc-dev/2007-December/047777.html
> >http://ozlabs.org/pipermail/linuxppc-dev/2007-December/047778.html
> >http://ozlabs.org/pipermail/linuxppc-dev/2007-December/047779.html
> >
> >^^ are mandatory to make MPC8349E-mITX's ENET1-ENET5 actually work.
> >Plus, as you may notice all of them having "777" in the message id,
> >they ought to be lucky, despite that today they're applying with
> >fuzz. :-)
> 
> I've got these in my queue to apply.

Great, good to know. Thanks.

> If I have issues I'll ping you for a respin.

Sure thing.

> >http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048473.html
> >
> >^^ fixed phy support for fs_enet. Needed for some other boards, I
> >presume.
> 
> Hmm, its vitaly picking this one up?  if not I can.

Ah, right. I just forgot that Vitaly resumed his tree.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
