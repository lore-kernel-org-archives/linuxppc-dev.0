Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B5647B6F69
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Nov 2011 04:59:19 +1100 (EST)
Subject: Re: [PATCH] powerpc/86xx: Correct Gianfar support for GE boards
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20111103173726.23924.83647.stgit@ES-BJ21R4J>
Date: Thu, 3 Nov 2011 12:59:10 -0500
Message-Id: <86053748-291E-484F-B071-02A3061ECC3F@kernel.crashing.org>
References: <20111103173726.23924.83647.stgit@ES-BJ21R4J>
To: Martyn Welch <martyn.welch@ge.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 3, 2011, at 12:37 PM, Martyn Welch wrote:

> The GE DTBs were not updated when the Gianfar driver was converted to =
an
> of_platform_driver in commit b31a1d8b41513b96e9c7ec2f68c5734cef0b26a4. =
Update
> the DTBs, adding the required TBI entries.
>=20
> Signed-off-by: Martyn Welch <martyn.welch@ge.com>
> ---
>=20
> arch/powerpc/boot/dts/gef_ppc9a.dts  |   33 =
+++++++++++++++++++++++++++++----
> arch/powerpc/boot/dts/gef_sbc310.dts |   33 =
+++++++++++++++++++++++++++++----
> arch/powerpc/boot/dts/gef_sbc610.dts |   33 =
+++++++++++++++++++++++++++++----
> 3 files changed, 87 insertions(+), 12 deletions(-)
>=20

applied

- k=
