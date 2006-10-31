Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 776ED67D41
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 13:55:26 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k9V4GRNh025351
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 21:16:27 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k9V2tN2b001294
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 20:55:24 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] qe_lib: Remove immrbar_virt_to_phys() function
Date: Tue, 31 Oct 2006 10:56:09 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D2632CE@zch01exm20.fsl.freescale.net>
In-Reply-To: <BAAA9C5D-78F6-4B72-8FCB-633464EA85FB@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> >> I'm confused, if there are other users of immrbar_virt_to_phy() how
> >> can you get ride of it completely?
> >
> > Other users will change to use iopa() instead.  There was some bug
to
> > use iopa() with io_block_mapping area, but it is ok to use it now.
>=20
> Hmm, what are the other users doing?  I think we should avoid using
> iopa.

Get physical address from virtual address.  I have considered to use
virt_to_phys(), but it is not consistent between ppc and powerpc arch.

- Leo
