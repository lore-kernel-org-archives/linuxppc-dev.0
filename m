Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqskw0X1vzDsPq
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 15:45:44 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Fabio Estevam <festevam@gmail.com>
Cc: paulus@samba.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "robh+dt\@kernel.org" <robh+dt@kernel.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] powerpc/40x: acadia: Fix the 'interrupt-parent' property
In-Reply-To: <CAOMZO5Ai_S7LpY20pH2LoGuQTrX4ZLevfEhvj+LRrK7DG06oNw@mail.gmail.com>
References: <1508245278-5692-1-git-send-email-fabio.estevam@nxp.com>
 <CAOMZO5Ai_S7LpY20pH2LoGuQTrX4ZLevfEhvj+LRrK7DG06oNw@mail.gmail.com>
Date: Mon, 04 Dec 2017 15:45:43 +1100
Message-ID: <87h8t73xu0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fabio Estevam <festevam@gmail.com> writes:

> Hi Michael,
>
> On Tue, Oct 17, 2017 at 11:01 AM, Fabio Estevam <fabio.estevam@nxp.com> wrote:
>> 'interrupts-parent' property does not exist. Fix the typo.
>>
>> Fixes: 00f3ca740a9c26 ("powerpc/40x: AMCC PowerPC 405EZ Acadia DTS")
>> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
>> ---
>>  arch/powerpc/boot/dts/acadia.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/boot/dts/acadia.dts b/arch/powerpc/boot/dts/acadia.dts
>> index 57291f6..8626615 100644
>> --- a/arch/powerpc/boot/dts/acadia.dts
>> +++ b/arch/powerpc/boot/dts/acadia.dts
>> @@ -183,7 +183,7 @@
>>                         usb@ef603000 {
>>                                 compatible = "ohci-be";
>>                                 reg = <0xef603000 0x80>;
>> -                               interrupts-parent = <&UIC0>;
>> +                               interrupt-parent = <&UIC0>;
>
> Any comments?

Nope :)

Will pick it up for 4.16.

cheers
