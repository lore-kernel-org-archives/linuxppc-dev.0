Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe001.messaging.microsoft.com [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EECC72C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 06:21:08 +1100 (EST)
Received: from mail1-db3 (localhost [127.0.0.1])	by mail1-db3-R.bigfish.com
 (Postfix) with ESMTP id 954C8220587	for <linuxppc-dev@lists.ozlabs.org>; Tue,
 2 Apr 2013 19:21:02 +0000 (UTC)
Received: from DB3EHSMHS001.bigfish.com (unknown [10.3.81.250])	by
 mail1-db3.bigfish.com (Postfix) with ESMTP id 6FD4E80299	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2013 19:19:57 +0000 (UTC)
Date: Tue, 2 Apr 2013 14:19:01 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/5] powerpc/fsl-booke: Add initial silicon device tree
 files for B4860 and B4420
To: Shaveta Leekha <shaveta@freescale.com>
References: <1364886968-9634-1-git-send-email-shaveta@freescale.com>
In-Reply-To: <1364886968-9634-1-git-send-email-shaveta@freescale.com> (from
 shaveta@freescale.com on Tue Apr  2 02:16:05 2013)
Message-ID: <1364930341.24520.15@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Zhao Chenhui <chenhui.zhao@freescale.com>,
 Tang Yuantian <Yuantian.Tang@freescale.com>,
 Shaveta Leekha <shaveta@freescale.com>, Vakul Garg <vakul@freescale.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>,
 Andy Fleming <afleming@freescale.com>,
 Ramneek Mehresh <ramneek.mehresh@freescale.com>,
 Varun Sethi <Varun.Sethi@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/02/2013 02:16:05 AM, Shaveta Leekha wrote:
> +/ {
> +	compatible =3D "fsl,B4860";
> +
> +	cpus {
> +		cpu1: PowerPC,e6500@1 {
> +			device_type =3D "cpu";
> +			reg =3D <2 3>;
> +			next-level-cache =3D <&L2>;
> +		};
> +		cpu2: PowerPC,e6500@2 {
> +			device_type =3D "cpu";
> +			reg =3D <4 5>;
> +			next-level-cache =3D <&L2>;
> +		};
> +		cpu3: PowerPC,e6500@3 {
> +			device_type =3D "cpu";
> +			reg =3D <6 7>;
> +			next-level-cache =3D <&L2>;
> +		};

The unit addresses need to match "reg".

-Scott=
