Return-Path: <leon.woestenberg@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 72EDEDE146
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 00:53:52 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so608701yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 08 Oct 2008 06:53:50 -0700 (PDT)
Message-ID: <c384c5ea0810080653x76234b4ma53188bed2a3d59d@mail.gmail.com>
Date: Wed, 8 Oct 2008 15:53:50 +0200
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"John Rigby" <jrigby@freescale.com>
Subject: Re: MPC8315ERDB PCI Express support status?
In-Reply-To: <9509FE83-529D-4C0B-B226-B7169FA727DB@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c384c5ea0810060642l2bbc2a08y5725a28b6d45aa8d@mail.gmail.com>
	<9509FE83-529D-4C0B-B226-B7169FA727DB@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Stuart Hughes <seh@zee2.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar, John,

On Mon, Oct 6, 2008 at 5:09 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
> On Oct 6, 2008, at 8:42 AM, Leon Woestenberg wrote:
>> can Freescale or any of the powerpc maintainers indicate to what
>> extend PCI Express support for the MPC8315E processor has been merged
>> to Linux mainline, or what is still needs review or attention?
>>
>> I could find u-boot and Linux patches provided by Freescale in their
>> [...]
>> but I could not easily identify what has been merged upstream.
>>
>> My first goal (and hardware on my desk) would be to test an Intel PCIe
>> PRO/1000 Ethernet adapter, as a start to add a custom PCIe FPGA
>> device.
>
> No PCI-e support for 83xx has been merged in any mainline kernel.
>

I got MPC8315E working with PCI Express, using an Intel PRO/1000 GbE
PCIe x1 card, using 2.6.24.3-rt3 with a lot of Freescale patches, as
well as u-boot 1.2.0 forward patched to 1.3.0 by Freescale with some
PCIe initialization work. So, basically the BSP 20080627.

I would like these patches to be ported forward to mainline, and I can
put some time in this, but I'ld rather first know what the Freescale
status on the patches is?

John, Stuart, could you please check if there is ongoing work in
Freescale? I hate double efforts when I'm short on time :-) Thanks.

Regards,
-- 
Leon
