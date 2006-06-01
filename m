Return-Path: <peter.ryser@xilinx.com>
Received: from outbound1-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3445267A58
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Jun 2006 03:06:02 +1000 (EST)
Message-ID: <447F1E48.10808@xilinx.com>
Date: Thu, 01 Jun 2006 10:05:12 -0700
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: Aidan Williams <aidan@nicta.com.au>
Subject: Re: Linux 2.4 Kernel on Xilinx Virtex4 FX100's PPC
References: <EDF27F298D4B03498AE0C249A941DFF803D6E6@de01exm68.ds.mot.com>
	<447E1725.4010908@nicta.com.au>
In-Reply-To: <447E1725.4010908@nicta.com.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Anantharaman Chetan-W16155 <Chetan.S.Anantharaman@motorola.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

There are some silicon issues on the PPC405 in V4 with PVR 0x20011430=20
which are documented in Xilinx solution record 20658. All these issues=20
are fixed in silicon where the PPC405 has a PVR of 0x20011470.

Said that it's not true that the caches cannot be used in silicon with=20
PVR 0x20011430. The problem is a corner case which does not show in=20
typical designs.

- Peter


Aidan Williams wrote:

>Anantharaman Chetan-W16155 wrote:
> =20
>
>>Has anyone successfully ported a Linux 2.4 Kernel on a Xilinx Virtex-4=20
>>FX series FPGA=92s, PPC405 processor?
>>
>>   =20
>>
>
>Yes, see=20
>http://ozlabs.org/pipermail/linuxppc-embedded/2006-April/022583.html
>
>Note that there are silicon bugs that prevent caches being used in some=20
>chips.
>
> =20
>
>>More specifically, the FX100 FPGA?
>>   =20
>>
>
>I don't have one of those, sorry.
>
>- aidan
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
> =20
>
