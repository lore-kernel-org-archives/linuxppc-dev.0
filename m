Return-Path: <B32616@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
 [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A4B87B6EFE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2012 20:57:43 +1100 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: Li Yang-R58472 <r58472@freescale.com>
Subject: RE: [PATCH][SDK v1.2] sata: I/O load balancing
Date: Fri, 13 Jan 2012 09:57:35 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB701320C@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1326443147-26645-1-git-send-email-qiang.liu@freescale.com>,
 <CADRPPNQsVB-2jR0UaX6RB_4PCf9kt4UXvAXnxaVk=LsBcwGowg@mail.gmail.com>
In-Reply-To: <CADRPPNQsVB-2jR0UaX6RB_4PCf9kt4UXvAXnxaVk=LsBcwGowg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "jgarzik@pobox.com" <jgarzik@pobox.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=0A=
________________________________________=0A=
> From: linux-ide-owner@vger.kernel.org [linux-ide-owner@vger.kernel.org] o=
n behalf of Li Yang [leoli@freescale.com]=0A=
> Sent: Friday, January 13, 2012 3:36 AM=0A=
> To: Liu Qiang-B32616=0A=
> Cc: jgarzik@pobox.com; linux-ide@vger.kernel.org; linux-kernel@vger.kerne=
l.org; linuxppc-dev@lists.ozlabs.org; Liu Qiang-B32616=0A=
> Subject: Re: [PATCH][SDK v1.2] sata: I/O load balancing=0A=
=0A=
> On Fri, Jan 13, 2012 at 4:25 PM, Qiang Liu <qiang.liu@freescale.com> wrot=
e:=0A=
> > From: Qiang Liu <b32616@freescale.com>=0A=
> >=0A=
> > Reduce interrupt singnals through reset Interrupt Coalescing Control Re=
g.=0A=
> > Increase the threshold value of interrupt and timer will reduce the num=
ber=0A=
> > of complete interrupt sharply. Improve the system performance effective=
ly.=0A=
=0A=
> There is always a trade off of throughput and latency by using=0A=
> interrupt coalescing.  It's not reasonable to assume that the=0A=
> throughput is the only factor to be considered and set the coalescing=0A=
> threshold and timeout to the max value by default.  Have you carried=0A=
> out other benchmark like copying many small files?=0A=
No, I didn't test small file. I think this won't affect system load. I can =
have a test=0A=
and describe the result in next patch.=0A=
=0A=
> It will be safer to make the coalescing runtime configurable like the=0A=
> sata_mv driver, IMO.=0A=
Ok, I will do it like this in next patch.=0A=
=0A=
=0A=
- Leo=0A=
--=0A=
To unsubscribe from this list: send the line "unsubscribe linux-ide" in=0A=
the body of a message to majordomo@vger.kernel.org=0A=
More majordomo info at  http://vger.kernel.org/majordomo-info.html=0A=
=0A=
