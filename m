Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 08B95B6F77
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Sep 2011 08:37:41 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] powerpc/85xx: Rename PowerPC core nodes to match
	other e500mc based .dts
Date: Thu, 1 Sep 2011 22:33:57 +0000
Message-ID: <CAOZdJXUfgkvCCgW-KEgGJ0wW+EyGnhf+=aLV7E4SsKBoztP7uQ@mail.gmail.com>
References: <1314905175-4371-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1314905175-4371-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 1, 2011 at 2:26 PM, Kumar Gala <galak@kernel.crashing.org> wrot=
e:
> The P4080 silicon device tree was using PowerPC,4080 while the other
> e500mc based SoCs used PowerPC,e500mc. =A0Use the core name to be
> consistent going forward.

Shouldn't we change the nodes for all e500 based device trees in one
shot, instead of just the P4080?

--=20
Timur Tabi
Linux kernel developer at Freescale=
