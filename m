Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe004.messaging.microsoft.com
 [216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F413DB6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 03:10:03 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Fan Zhicheng-B32736 <B32736@freescale.com>
Subject: Re: [PATCH 1/2 v4] powerpc/85xx: Add p1020rdb-pc platform support
Date: Thu, 9 Feb 2012 16:09:52 +0000
Message-ID: <CAOZdJXWUSiBRuVWpErOG8eYMLjLd+_FxQ+JPwm=YmTWSvZ-zAA@mail.gmail.com>
References: <1328766036-17697-1-git-send-email-B32736@freescale.com>
In-Reply-To: <1328766036-17697-1-git-send-email-B32736@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhicheng Fan <b32736@freeescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 8, 2012 at 11:40 PM, Zhicheng Fan <B32736@freescale.com> wrote:

> +static int __init p1020_rdb_pc_probe(void)
> +{
> + =A0 =A0 =A0 unsigned long root =3D of_get_flat_dt_root();
> +
> + =A0 =A0 =A0 if (of_flat_dt_is_compatible(root, "fsl,P1020RDB-PC"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 return 0;
> +}

static int __init p1020_rdb_pc_probe(void)
{
       unsigned long root =3D of_get_flat_dt_root();

       return of_flat_dt_is_compatible(root, "fsl,P1020RDB-PC");
}

--=20
Timur Tabi
Linux kernel developer at Freescale=
