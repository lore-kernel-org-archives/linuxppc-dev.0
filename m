Return-Path: <B19537@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7BA0E2C0158
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Apr 2013 21:46:47 +1000 (EST)
From: Luo Zhenhua-B19537 <B19537@freescale.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: RE: [PATCH] Enable CONFIG_DEVTMPFS_MOUNT to ensure /dev can be
 mounted correctly
Date: Wed, 17 Apr 2013 11:46:40 +0000
Message-ID: <CA452391058F6D4E9715FB2C29D9312A014D3107@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1365688591-5323-1-git-send-email-zhenhua.luo@freescale.com>
 <20130415050129.GB21147@concordia>
In-Reply-To: <20130415050129.GB21147@concordia>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Michael Ellerman [mailto:michael@ellerman.id.au]
> Sent: Monday, April 15, 2013 1:02 PM
>=20
> On Thu, Apr 11, 2013 at 09:56:30PM +0800, Zhenhua Luo wrote:
> > When using recent udev, the /dev node mount requires
> > CONFIG_DEVTMPFS_MOUNT is enabled in Kernel.
>=20
> Really?
>=20
> I know it makes life easier when you don't have an initramfs, but is it
> actually required now?
[Luo Zhenhua-B19537] I didn't use initramfs when the issue is found, I thin=
k the option is required to be enabled.=20


Best Regards,

Zhenhua
