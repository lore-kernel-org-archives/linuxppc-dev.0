Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D30A3DE3E3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 03:56:57 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5BHurFQ021576
	for <linuxppc-embedded@ozlabs.org>; Wed, 11 Jun 2008 13:56:53 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5BHurKB228314
	for <linuxppc-embedded@ozlabs.org>; Wed, 11 Jun 2008 13:56:53 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5BHura1002446
	for <linuxppc-embedded@ozlabs.org>; Wed, 11 Jun 2008 13:56:53 -0400
Date: Wed, 11 Jun 2008 13:56:18 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Darcy Watkins" <DWatkins@tranzeo.com>
Subject: Re: PPC to PowerPC Migration
Message-ID: <20080611135618.001db94d@zod.rchland.ibm.com>
In-Reply-To: <D61182AC8012EA4EBC531B3AF23BE109603587@tranzeo-mail2.12stewart.tranzeo.com>
References: <c443b0db0806101048t1df8c11ag456fbc352709966b@mail.gmail.com>
	<161B3BAD77161449A144FF054231C3D6022A3E4A@uss-am-xch-01.am.trimblecorp.net>
	<f608b67d0806110655v19dac162wc3adfc8939b5c40a@mail.gmail.com>
	<D61182AC8012EA4EBC531B3AF23BE10960355D@tranzeo-mail2.12stewart.tranzeo.com>
	<20080611123254.64fabf64@vader.jdub.homelinux.org>
	<D61182AC8012EA4EBC531B3AF23BE109603578@tranzeo-mail2.12stewart.tranzeo.com>
	<20080611133247.0ac8b7c6@zod.rchland.ibm.com>
	<D61182AC8012EA4EBC531B3AF23BE109603587@tranzeo-mail2.12stewart.tranzeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 11 Jun 2008 10:52:13 -0700
"Darcy Watkins" <DWatkins@tranzeo.com> wrote:

> Hi Josh,
> 
> Is there a special git tree for 4xx or are you referring to kernel.org?
> ... or do I just post the patches to this list?

http://git.kernel.org/?p=linux/kernel/git/jwboyer/powerpc-4xx.git;a=summary

You can clone it with:

git clone \
git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git

The 'next' branch contains the current stuff heading into whatever is
the next merge window (which right now would be 2.6.27.

You can post patches here, but most of them go to the linuxppc-dev list
now.

josh
