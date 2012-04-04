Return-Path: <tinamdar@apm.com>
Received: from exprod5og107.obsmtp.com (exprod5og107.obsmtp.com [64.18.0.184])
 by ozlabs.org (Postfix) with SMTP id DCEC8B6FFA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2012 15:45:09 +1000 (EST)
Received: by iagk10 with SMTP id k10so769005iag.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2012 22:45:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+5PVA4_PJ2T7LGM_N_WemQKY2u6bLg0QFk4wPpd=FGESx7eiQ@mail.gmail.com>
References: <1333348747-12713-1-git-send-email-tinamdar@apm.com>
 <1333348747-12713-2-git-send-email-tinamdar@apm.com>
 <1333348747-12713-3-git-send-email-tinamdar@apm.com>
 <20120403155703.3B0593E053F@localhost>
 <CA+5PVA4_PJ2T7LGM_N_WemQKY2u6bLg0QFk4wPpd=FGESx7eiQ@mail.gmail.com>
Date: Wed, 4 Apr 2012 11:09:30 +0530
Message-ID: <CACoXjckmC-3p1Wx-fEQo0MmgH4rKGT4gRKjJ6BdvrjVy6dRrKw@mail.gmail.com>
Subject: Re: [PATCH 3/5] powerpc: dts: klondike: Add UART nodes
From: Tanmay Inamdar <tinamdar@apm.com>
To: Josh Boyer <jwboyer@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 4, 2012 at 6:19 AM, Josh Boyer <jwboyer@gmail.com> wrote:
> On Tue, Apr 3, 2012 at 11:57 AM, Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>> On Mon, =A02 Apr 2012 12:09:05 +0530, Tanmay Inamdar <tinamdar@apm.com> =
wrote:
>>> Adding UART nodes in Klondike device tree file.
>>>
>>> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
>>> ---
>>> :100644 100644 4ff2852... d5bf2e1... M =A0 =A0 =A0 =A0arch/powerpc/boot=
/dts/klondike.dts
>>> =A0arch/powerpc/boot/dts/klondike.dts | =A0 24 ++++++++++++++++++++++++
>>> =A01 files changed, 24 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/powerpc/boot/dts/klondike.dts b/arch/powerpc/boot/dts=
/klondike.dts
>>> index 4ff2852..d5bf2e1 100644
>>> --- a/arch/powerpc/boot/dts/klondike.dts
>>> +++ b/arch/powerpc/boot/dts/klondike.dts
>>> @@ -222,6 +222,30 @@
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells=
 =3D <1>;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequ=
ency =3D <0>;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UART0: serial=
@50001000 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0device_type =3D "serial";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0compatible =3D "ns16550";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0reg =3D <0x50001000 0x00000100>;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0virtual-reg =3D <0x50001000>;
>>
>> Why do you need virtual-reg? =A0The kernel should handle all iomapping
>> properly without this.
>
> Right. =A0It's been used for platforms that actually use the
> zImage/treeImage wrapper for printf support, but this uses u-boot as
> far as I know. =A0It shouldn't need it.
>

Agreed. 'virtual-reg' is not required here. I will remove it in next
version of patch.

> josh
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, =

is for the sole use of the intended recipient(s) and contains information=
=A0
that is confidential and proprietary to AppliedMicro Corporation or its s=
ubsidiaries. =

It is to be used solely for the purpose of furthering the parties' busine=
ss relationship. =

All unauthorized review, use, disclosure or distribution is prohibited. =

If you are not the intended recipient, please contact the sender by reply=
 e-mail =

and destroy all copies of the original message.
=0D
