Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6E952DE240
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 07:01:42 +1000 (EST)
Message-ID: <482CA47C.1020403@freescale.com>
Date: Thu, 15 May 2008 16:00:44 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>, Kumar Gala <kumar.gala@freescale.com>
Subject: Re: Patches added to powerpc.git powerpc-next branch
References: <18475.30315.579805.168910@cargo.ozlabs.ibm.com>
In-Reply-To: <18475.30315.579805.168910@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> I have added the following patches to the powerpc-next and master
> branches of the powerpc.git repository.  This includes commits pulled
> from Kumar's tree.

What about these:

[PATCH] Add null pointer check to of_find_property
[PATCH v2] Update defconfig for MPC8610 HPCD

-- 
Timur Tabi
Linux kernel developer at Freescale
