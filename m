Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 18D69DDF3A
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 00:09:57 +1000 (EST)
Message-ID: <48318A25.1000003@freescale.com>
Date: Mon, 19 May 2008 09:09:41 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Patches added to powerpc.git powerpc-next branch
References: <18478.26326.727525.687997@cargo.ozlabs.ibm.com>
In-Reply-To: <18478.26326.727525.687997@cargo.ozlabs.ibm.com>
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
> I have pulled Linus' tree into the powerpc-next branch of powerpc.git,
> and added the following 4 patches.

Paul,

I don't want to nag, but I would like to know if and when you're planning on
pulling this patch of mine:

[PATCH] Add null pointer check to of_find_property

I have code in the ASoC repository that depends on this patch.

-- 
Timur Tabi
Linux kernel developer at Freescale
