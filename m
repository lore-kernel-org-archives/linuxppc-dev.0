Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CB9E4B6FF9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 02:40:26 +1100 (EST)
Subject: Re: [PATCH 3/4] powerpc/85xx: add the P1020MBG-PC DTS support
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331716110-25545-3-git-send-email-Chang-Ming.Huang@freescale.com>
Date: Fri, 16 Mar 2012 10:40:18 -0500
Message-Id: <0B285007-CCFC-4EA0-9667-79C920E347BC@kernel.crashing.org>
References: <1331716110-25545-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1331716110-25545-2-git-send-email-Chang-Ming.Huang@freescale.com>
 <1331716110-25545-3-git-send-email-Chang-Ming.Huang@freescale.com>
To: "<Chang-Ming.Huang@freescale.com>" <Chang-Ming.Huang@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 14, 2012, at 4:08 AM, <Chang-Ming.Huang@freescale.com> =
<Chang-Ming.Huang@freescale.com> wrote:

> +		partition@0 {
> +			/* 128KB for DTB Image */
> +			reg =3D <0x0 0x00020000>;
> +			label =3D "NOR (RO) DTB Image";
> +			read-only;
> +		};
> +

How many times are we going to say to remove '(RO)' from the labels???

- k=
