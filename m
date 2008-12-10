Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CC509474C8
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 01:04:34 +1100 (EST)
Date: Wed, 10 Dec 2008 06:04:28 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Liu Yu <yu.liu@freescale.com>
Subject: Re: [PATCH] fsl-booke: declare tlbcam_index and num_tlbcam_entries
	for use in c file
In-Reply-To: <1228898473-29986-1-git-send-email-yu.liu@freescale.com>
Message-ID: <Pine.LNX.4.64.0812100602210.28806@t2.domain.actdsltmp>
References: <1228898473-29986-1-git-send-email-yu.liu@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 10 Dec 2008, Liu Yu wrote:
> KVM on E500 platform currently utilize TLB1 entries without bothering host,
> that is using unused TLB1 entries.
>
> So, KVM needs to read tlbcam_index and num_tlbcam_entries to know exactly
> which TLB1 entry is unused.

Do you need really need num_tlbcam_entries?  It's completely unused and
I've already sent out a patch to remove it.  If you want to know how
big TLB1 is, just read it from SPRN_TLB1CFG.
