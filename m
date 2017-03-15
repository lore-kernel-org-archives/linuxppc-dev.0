Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjkck0xxMzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 19:03:18 +1100 (AEDT)
Received: by mail-it0-x242.google.com with SMTP id 14so2367625itw.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 01:03:18 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <87a88nv1b2.fsf@concordia.ellerman.id.au>
References: <1489324627-19126-1-git-send-email-geert@linux-m68k.org>
 <1489324627-19126-17-git-send-email-geert@linux-m68k.org>
 <87a88nv1b2.fsf@concordia.ellerman.id.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Mar 2017 09:03:13 +0100
Message-ID: <CAMuHMdX95zwQUe8XyPpKvv6zsHG+c1Ke=eFBZCt+fNUxgP5O2g@mail.gmail.com>
Subject: Re: [PATCH v2 16/23] MAINTAINERS: Add file patterns for powerpc
 device tree bindings
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Scott Wood <oss@buserror.net>,
 Qiang Zhao <qiang.zhao@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>,
 york.sun@nxp.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Wed, Mar 15, 2017 at 1:19 AM, Michael Ellerman <mpe@ellerman.id.au> wrot=
e:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> Submitters of device tree binding documentation may forget to CC
>> the subsystem maintainer if this is missing.
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> ---
>> Please apply this patch directly if you want to be involved in device
>> tree binding documentation for your subsystem.
>>
>> v2:
>>   - Rebased on top of commit a42715830d552d7c ("MAINTAINERS: Remove
>>     powerpc's "opal" pattern match), which just added "powerpc/opal",
>>     while obviously the whole "powerpc" hierarchy is of interest.
>>
>> Impact on next-20170310:
>
> Actual diff ignoring ordering etc:
>
>  +Benjamin Herrenschmidt <benh@kernel.crashing.org> (supporter:LINUX FOR =
POWERPC (32-BIT AND 64-BIT))
>  +Paul Mackerras <paulus@samba.org> (supporter:LINUX FOR POWERPC (32-BIT =
AND 64-BIT))
>  +linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND =
64-BIT))
>  -Scott Wood <oss@buserror.net> (commit_signer:5/11=3D45%)
>  -Zhao Qiang <qiang.zhao@nxp.com> (commit_signer:4/11=3D36%,authored:4/11=
=3D36%)
>  -Christian Lamparter <chunkeey@googlemail.com> (commit_signer:1/11=3D9%)
>  -yangbo lu <yangbo.lu@nxp.com> (authored:1/11=3D9%)
>  -"Otto Kek=C3=A4l=C3=A4inen" <otto@seravo.fi> (authored:1/11=3D9%)
>  -Chris Packham <chris.packham@alliedtelesis.co.nz> (authored:1/11=3D9%)
>  -York Sun <york.sun@nxp.com> (authored:1/11=3D9%)
>
> Which looks bad as all the NXP folks get dropped, but they should be
> reading linuxppc-dev. So I think I'll merge this, unless anyone
> disagrees.

They got dropped because in the absence of a maintainer entry, the
last committers are listed. If they need to be listed, I can send patches t=
o add
more specific entries for 4xx and fsl DT bindings, like:

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f1c2f96c99aa936..40b392a4f399adbe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5266,6 +5266,7 @@ M:        Scott Wood <oss@buserror.net>
 L:     linuxppc-dev@lists.ozlabs.org
 L:     linux-arm-kernel@lists.infradead.org
 S:     Maintained
+F:     Documentation/devicetree/bindings/powerpc/fsl/
 F:     drivers/soc/fsl/
 F:     include/linux/fsl/

@@ -7540,6 +7541,7 @@ M:        Matt Porter <mporter@kernel.crashing.org>
 W:     http://www.penguinppc.org/
 L:     linuxppc-dev@lists.ozlabs.org
 S:     Maintained
+F:     Documentation/devicetree/bindings/powerpc/4xx/
 F:     arch/powerpc/platforms/40x/
 F:     arch/powerpc/platforms/44x/


OK?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
