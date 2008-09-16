Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-2.online-age.net (ext-nj2ut-2.online-age.net
	[64.14.54.231])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id F2FB8DDDE6
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2008 01:04:47 +1000 (EST)
Received: from int-nj2ut-3.online-age.net (int-nj2ut-3.online-age.net
	[3.159.237.72])
	by ext-nj2ut-2.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m8GF4hUV024568
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 11:04:44 -0400
Received: from cinmlip01.e2k.ad.ge.com (int-nj2ut-3.online-age.net
	[3.159.237.72])
	by int-nj2ut-3.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m8GF4hLu014374
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 11:04:43 -0400
Date: Tue, 16 Sep 2008 16:04:55 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v5 0/2] powerpc: Board support for GE Fanuc SBC610
Message-ID: <20080916160455.278da8be@ubuntu8041.localdomain>
In-Reply-To: <108F19DB-702D-4FA9-A8A6-6239DFD30043@kernel.crashing.org>
References: <18638.50702.962371.862911@cargo.ozlabs.ibm.com>
	<20080916095741.9992.96106.stgit@ubuntu8041.localdomain>
	<108F19DB-702D-4FA9-A8A6-6239DFD30043@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 16 Sep 2008 09:54:59 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Sep 16, 2008, at 4:57 AM, Martyn Welch wrote:
> 
> > The following series implements basic board support for GE Fanuc's  
> > SBC610, a
> > 6U single board computer, based on Freescale's MPC8641D.
> >
> > This series provides basic functionality:
> > - The board can boot with a serial console.
> > - Ethernet works, though the phys are polled.
> > - The PCI bus is scanned and sata functions.
> >
> > Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> 
> what changed in v5?
> 
The patches as sent earlier today were the same as those sent on the
4th, as part of Paul's request for those wishing their patches to be
included on the new patchwork page. The changes were: 

I have removed un-needed entries from of_bus_ids[] and added
"simple-bus" compatible node to soc in the DTS.

Sorry if you didn't get CCed on the previous release. I use STGit to
push the patches and it seems to arbitrarily loose some CCed
parties if multiple --CC options are given. It's seems happier with all
CCs in a list.

Martyn

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)
T:+44(0)1327322748 GE Fanuc Intelligent Platforms Ltd,
|Registered in England and Wales Tove Valley Business Park,
Towcester,      |(3828642) at 100 Barbirolli Square, Northants, NN12
6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
