Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B24EDDEE7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 03:33:40 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5BHXbi5009626
	for <linuxppc-embedded@ozlabs.org>; Wed, 11 Jun 2008 13:33:37 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5BHXaov171638
	for <linuxppc-embedded@ozlabs.org>; Wed, 11 Jun 2008 11:33:36 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5BHXaul030934
	for <linuxppc-embedded@ozlabs.org>; Wed, 11 Jun 2008 11:33:36 -0600
Date: Wed, 11 Jun 2008 13:32:47 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Darcy Watkins" <DWatkins@tranzeo.com>
Subject: Re: PPC to PowerPC Migration
Message-ID: <20080611133247.0ac8b7c6@zod.rchland.ibm.com>
In-Reply-To: <D61182AC8012EA4EBC531B3AF23BE109603578@tranzeo-mail2.12stewart.tranzeo.com>
References: <c443b0db0806101048t1df8c11ag456fbc352709966b@mail.gmail.com>
	<161B3BAD77161449A144FF054231C3D6022A3E4A@uss-am-xch-01.am.trimblecorp.net>
	<f608b67d0806110655v19dac162wc3adfc8939b5c40a@mail.gmail.com>
	<D61182AC8012EA4EBC531B3AF23BE10960355D@tranzeo-mail2.12stewart.tranzeo.com>
	<20080611123254.64fabf64@vader.jdub.homelinux.org>
	<D61182AC8012EA4EBC531B3AF23BE109603578@tranzeo-mail2.12stewart.tranzeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: vb <vb@vsbe.com>, Mike Timmons <mike_timmons@trimble.com>, Andy
	Schmidt <andrewgschmidt@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 11 Jun 2008 10:15:03 -0700
"Darcy Watkins" <DWatkins@tranzeo.com> wrote:

> Hi Josh,
> 
> I think it would be more helpful if I were to tidy it a bit and add AMCC
> Taihu boot support to it first.  Then submit it.  People are more likely
> to have access to a Taihu than one of our boards.
> 
> What I mean by "AMCC Taihu boot support" is that the board would come up
> just like our Taihushui/Kolsch family of boards, but would not include
> the extra drivers, etc needed for USB gadgets, the LCD and other like
> items that are on the AMCC board.

That sounds like a fine plan.  If you'd like, you can submit both at
the same time (as separate patches).  More board ports are always
welcome, particularly for stock eval boards.

> Once I get this done, I can submit BSP patch sets for kernel 2.6.25 and
> 2.6.26.  If there is demand, I could submit a BSP patch set for 2.6.24
> as well.

Preferably, you'd submit to the tip of the git tree for 4xx.  With the
pace of kernel development, releasing patches for "old" kernels just
means that someone has to forward port them to the latest tree.  That
might be a small effort, but in practice it's best to work with
bleeding edge if you're going to submit a patch for inclusion.

Don't be discouraged by that.  There are those that will help you if
you run into obstacles.

> Please send me (or URL to) summarized patch submission instructions /
> guidelines.

The easiest place to start is Documentation/SubmittingPatches in the
kernel tree.

josh
