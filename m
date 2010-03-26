Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D5927B7BEE
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Mar 2010 06:50:32 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o2QJoTJY017744
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 12:50:29 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o2QJoXaO020534
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 14:50:33 -0500 (CDT)
Message-ID: <4BAD1004.5050507@freescale.com>
Date: Fri, 26 Mar 2010 14:50:28 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [v2] powerpc/fsl: add device tree binding for QE firmware
References: <1269632145-28462-1-git-send-email-timur@freescale.com>
	<fa686aa41003261245h52e151ceoa4f85e38055ae6a7@mail.gmail.com>
In-Reply-To: <fa686aa41003261245h52e151ceoa4f85e38055ae6a7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: wmb@firmworks.com, linuxppc-dev@ozlabs.org,
	devicetree-discuss@lists.ozlabs.org, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> The node must be a child of a QE node.  A QE node can reference the
> firmware from another QE node by using the fsl,firmware-phandle
> property.

Ok.

I'll post a V3 once everyone else has a chance to comment.

-- 
Timur Tabi
Linux kernel developer at Freescale
