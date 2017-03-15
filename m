Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjXKt1LTtzDqXc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 11:19:46 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 <oss@buserror.net>, <qiang.zhao@nxp.com>, <yangbo.lu@nxp.com>,
 <york.sun@nxp.com>
Subject: Re: [PATCH v2 16/23] MAINTAINERS: Add file patterns for powerpc
 device tree bindings
In-Reply-To: <1489324627-19126-17-git-send-email-geert@linux-m68k.org>
References: <1489324627-19126-1-git-send-email-geert@linux-m68k.org>
 <1489324627-19126-17-git-send-email-geert@linux-m68k.org>
Date: Wed, 15 Mar 2017 11:19:45 +1100
Message-ID: <87a88nv1b2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Submitters of device tree binding documentation may forget to CC
> the subsystem maintainer if this is missing.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
> Please apply this patch directly if you want to be involved in device
> tree binding documentation for your subsystem.
>
> v2:
>   - Rebased on top of commit a42715830d552d7c ("MAINTAINERS: Remove
>     powerpc's "opal" pattern match), which just added "powerpc/opal",
>     while obviously the whole "powerpc" hierarchy is of interest.
>
> Impact on next-20170310:

Actual diff ignoring ordering etc:

 +Benjamin Herrenschmidt <benh@kernel.crashing.org> (supporter:LINUX FOR PO=
WERPC (32-BIT AND 64-BIT))
 +Paul Mackerras <paulus@samba.org> (supporter:LINUX FOR POWERPC (32-BIT AN=
D 64-BIT))
 +linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64=
-BIT))
 -Scott Wood <oss@buserror.net> (commit_signer:5/11=3D45%)
 -Zhao Qiang <qiang.zhao@nxp.com> (commit_signer:4/11=3D36%,authored:4/11=
=3D36%)
 -Christian Lamparter <chunkeey@googlemail.com> (commit_signer:1/11=3D9%)
 -yangbo lu <yangbo.lu@nxp.com> (authored:1/11=3D9%)
 -"Otto Kek=C3=A4l=C3=A4inen" <otto@seravo.fi> (authored:1/11=3D9%)
 -Chris Packham <chris.packham@alliedtelesis.co.nz> (authored:1/11=3D9%)
 -York Sun <york.sun@nxp.com> (authored:1/11=3D9%)

Which looks bad as all the NXP folks get dropped, but they should be
reading linuxppc-dev. So I think I'll merge this, unless anyone
disagrees.

cheers
