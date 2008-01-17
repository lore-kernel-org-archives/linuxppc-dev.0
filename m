Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 75765DDED8
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 02:11:06 +1100 (EST)
Message-Id: <A1DA2145-E5AE-4A7D-83D4-D86F05A9F6DF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080117145903.GA4535@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: Patches added to master/for-2.6.25 branch of powerpc.git
Date: Thu, 17 Jan 2008 09:11:00 -0600
References: <18318.56299.476711.644917@cargo.ozlabs.ibm.com>
	<20080117145903.GA4535@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 17, 2008, at 8:59 AM, Anton Vorontsov wrote:

> Hello Paul, Kumar,
>
> On Thu, Jan 17, 2008 at 03:39:07PM +1100, Paul Mackerras wrote:
>> Includes commits pulled from Josh Boyer's tree.
>
> Um.. Probably I'm being importunate.. if so, just command me to sit
> silent and wait. ;-) But how about these down here? Ones that touches
> drivers/net/ are having "Acked-by: Jeff Garzik <jeff@garzik.org>"
> thus meant to go through one of powerpc tree. Not sure through which
> one exactly.
>
> http://ozlabs.org/pipermail/linuxppc-dev/2007-December/047777.html
> http://ozlabs.org/pipermail/linuxppc-dev/2007-December/047778.html
> http://ozlabs.org/pipermail/linuxppc-dev/2007-December/047779.html
>
> ^^ are mandatory to make MPC8349E-mITX's ENET1-ENET5 actually work.
> Plus, as you may notice all of them having "777" in the message id,
> they ought to be lucky, despite that today they're applying with
> fuzz. :-)

I've got these in my queue to apply.  If I have issues I'll ping you  
for a respin.

> http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048473.html
>
> ^^ fixed phy support for fs_enet. Needed for some other boards, I
> presume.

Hmm, its vitaly picking this one up?  if not I can.

- k
