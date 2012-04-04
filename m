Return-Path: <jwboyer@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20120403155703.3B0593E053F@localhost>
References: <1333348747-12713-1-git-send-email-tinamdar@apm.com>
 <1333348747-12713-2-git-send-email-tinamdar@apm.com>
 <1333348747-12713-3-git-send-email-tinamdar@apm.com>
 <20120403155703.3B0593E053F@localhost>
Date: Tue, 3 Apr 2012 20:49:40 -0400
Message-ID: <CA+5PVA4_PJ2T7LGM_N_WemQKY2u6bLg0QFk4wPpd=FGESx7eiQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] powerpc: dts: klondike: Add UART nodes
From: Josh Boyer <jwboyer@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 Tanmay Inamdar <tinamdar@apm.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 3, 2012 at 11:57 AM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> On Mon, =A02 Apr 2012 12:09:05 +0530, Tanmay Inamdar <tinamdar@apm.com> w=
rote:
>> Adding UART nodes in Klondike device tree file.
>>
>> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
>> ---
>> :100644 100644 4ff2852... d5bf2e1... M =A0 =A0 =A0 =A0arch/powerpc/boot/=
dts/klondike.dts
>> =A0arch/powerpc/boot/dts/klondike.dts | =A0 24 ++++++++++++++++++++++++
>> =A01 files changed, 24 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/boot/dts/klondike.dts b/arch/powerpc/boot/dts/=
klondike.dts
>> index 4ff2852..d5bf2e1 100644
>> --- a/arch/powerpc/boot/dts/klondike.dts
>> +++ b/arch/powerpc/boot/dts/klondike.dts
>> @@ -222,6 +222,30 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =
=3D <1>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-freque=
ncy =3D <0>;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UART0: serial@=
50001000 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0device_type =3D "serial";
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0compatible =3D "ns16550";
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0reg =3D <0x50001000 0x00000100>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0virtual-reg =3D <0x50001000>;
>
> Why do you need virtual-reg? =A0The kernel should handle all iomapping
> properly without this.

Right.  It's been used for platforms that actually use the
zImage/treeImage wrapper for printf support, but this uses u-boot as
far as I know.  It shouldn't need it.

josh
