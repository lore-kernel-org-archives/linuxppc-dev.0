Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 013FCB6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 01:35:19 +1000 (EST)
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6CCD0DDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 01:35:18 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7HFTI27025156
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2009 11:29:18 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7HFZEVg256946
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2009 11:35:14 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7HFZCk1028655
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2009 11:35:13 -0400
Date: Mon, 17 Aug 2009 11:34:56 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Feng Kan <fkan@amcc.com>
Subject: Re: [PATCH 1/1 v1] powerpc44x: Add Eiger AMCC (AppliedMicro)
	PPC460SX evaluation board support.
Message-ID: <20090817153456.GD8710@zod.rchland.ibm.com>
References: <1250123927-29167-1-git-send-email-fkan@amcc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1250123927-29167-1-git-send-email-fkan@amcc.com>
Cc: linuxppc-dev@ozlabs.org, Tai Tri Nguyen <ttnguyen@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 12, 2009 at 05:38:47PM -0700, Feng Kan wrote:
>This patch adds support for the AMCC (AppliedMicro) PPC460SX Eiger evaluation board.
>
>Signed-off-by: Tai Tri Nguyen <ttnguyen@amcc.com>
>Acked-by: Feng Kan <fkan@amcc.com>
>Acked-by: Tirumala Marri <tmarri@amcc.com>
>---
> arch/powerpc/boot/dts/eiger.dts            |  421 ++++++++++
> arch/powerpc/configs/44x/eiger_defconfig   | 1200 ++++++++++++++++++++++++++++
> arch/powerpc/platforms/44x/Kconfig         |   12 +
> arch/powerpc/platforms/44x/ppc44x_simple.c |    1 +
> 4 files changed, 1634 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/eiger.dts
> create mode 100644 arch/powerpc/configs/44x/eiger_defconfig

Thanks, this looks great.

If you have no objections, I will commit an updated defconfig against the
current kernel sources instead of the one attached.  Some of the options
will move around a bit, but there should be no overall changes.

josh
