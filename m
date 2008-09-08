Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CE52CDDECF
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 07:35:42 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m88Lc7ZX012653
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Sep 2008 17:38:07 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m88LZJIC187772
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Sep 2008 17:35:19 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m88LZIEl003945
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Sep 2008 17:35:19 -0400
Date: Mon, 8 Sep 2008 17:35:09 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Prodyut Hazarika" <phazarika@amcc.com>
Subject: Re: Question on 4xx GIT tree
Message-ID: <20080908173509.7cccdbc7@zod.rchland.ibm.com>
In-Reply-To: <0CA0A16855646F4FA96D25A158E299D604F7F1A4@SDCEXCHANGE01.ad.amcc.com>
References: <0CA0A16855646F4FA96D25A158E299D604F7F1A4@SDCEXCHANGE01.ad.amcc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 8 Sep 2008 13:55:26 -0700
"Prodyut Hazarika" <phazarika@amcc.com> wrote:

> Hi Josh,
> I am planning to submit a patch to support 4K/16K and 64K page size for 4xx processors.
> I see that your git tree still has the include/asm-powerpc/* header files, while in Linus's git tree, the powerpc specific header file has been moved to arch/powerpc/include/asm.

I assume you're looking at my master branch.  That was a bit old and
I've updated it now to match the overall powerpc.git tree master
branch.  Sorry about that, I'll be a bit more diligent in keeping it
updated from now on.

> Should I base my patch from your git tree or Linus's git tree? Please advice how to proceed since I want your efforts in merging as painless as possible.

Generally, if you track my 'next' branch that is what will be most
current for 4xx.  It contains patches that aren't anywhere else at the
moment.

josh
