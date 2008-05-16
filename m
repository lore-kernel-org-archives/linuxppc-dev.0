Return-Path: <mchan@broadcom.com>
Received: from MMS3.broadcom.com (mms3.broadcom.com [216.31.210.19])
	by ozlabs.org (Postfix) with ESMTP id AEED5DDEE2
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 01:09:20 +1000 (EST)
MIME-Version: 1.0
Subject: Re: dead network on JS21 with tg3 driver after flowcontrol
 changes
Date: Fri, 16 May 2008 08:09:02 -0700
Message-ID: <1551EAE59135BE47B544934E30FC4FC002AABCF8@nt-irva-0751.brcm.ad.broadcom.com>
In-Reply-To: <20080516081330.GA26530@aepfle.de>
From: "Michael Chan" <mchan@broadcom.com>
To: "Olaf Hering" <olaf@aepfle.de>
Content-Type: text/plain;
 charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Matthew Carlson <mcarlson@broadcom.com>,
	netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering wrote:

> Yes, this patch fixes nfsroot for me. Thanks.
> mii-tool is not shipped anymore, even in SLES10.
> I assume that ethtool is the replacement?
>=20

Thanks.  We'll send the patch to DaveM and to stable
as well.

ethtool can provide some high level link parameters.
But in this case, I was trying to use mii-tool to
look at the PHY registers to help debug the problem.
ethtool would not provide that kind of information.
