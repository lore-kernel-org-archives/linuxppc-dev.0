Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F0D26DF417
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 07:20:57 +1000 (EST)
Message-ID: <46E9A987.9030908@freescale.com>
Date: Thu, 13 Sep 2007 16:20:07 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 10/10] mpc82xx: Add pq2fads board support.
References: <20070905192924.GI32462@ld0162-tx32.am.freescale.net>
	<9BC5B02A-4E9D-42DD-90C3-F8C3382F2A96@kernel.crashing.org>
	<20070913160539.GA32696@ld0162-tx32.am.freescale.net>
	<E7B70993-BC1A-4DB1-9497-D2D8994AB366@kernel.crashing.org>
In-Reply-To: <E7B70993-BC1A-4DB1-9497-D2D8994AB366@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> No problem.  The cpm2_* code in the kernel is used on 85xx's that have a 
> CPM and I don't think we have that much ifdef for 85xx specific CPM 
> foo.  Only thing I can think of is this bit in cpm2.h:
> 
> #if defined(CONFIG_8272) || defined(CONFIG_MPC8555)
> #define CPM_DATAONLY_SIZE       ((uint)(8 * 1024) - CPM_DATAONLY_BASE)
> #define CPM_FCC_SPECIAL_BASE    ((uint)0x00009000)
> #else

CPM_FCC_SPECIAL_BASE doesn't appear to be used anywhere in arch/powerpc.
CPM_DATAONLY_SIZE shouldn't be used anymore after this patchset.

-Scott
