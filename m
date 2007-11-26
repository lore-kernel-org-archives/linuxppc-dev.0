Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3D55FDDE01
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 10:42:08 +1100 (EST)
Subject: Re: [PATCH 2/2] [PPC 44x] enable L2-cache for ALPR, Katmai,
	Ocotea, and Taishan
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yuri Tikhonov <yur@emcraft.com>
In-Reply-To: <1416528026.20071107014041@emcraft.com>
References: <1416528026.20071107014041@emcraft.com>
Content-Type: text/plain
Date: Tue, 27 Nov 2007 10:41:46 +1100
Message-Id: <1196120506.7157.18.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, dzu@denx.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

BTW... Do you know why we can't just enable HW snoop ? The 440SPe
documentation seems to indicate that this is supported by the L2 cache
via snooping on the PLB.

Cheers,
Ben.
