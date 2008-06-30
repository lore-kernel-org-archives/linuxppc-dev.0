Return-Path: <Andre.Schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 8A4C1DDFDB
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 03:14:15 +1000 (EST)
Message-ID: <4869146B.8050609@matrix-vision.de>
Date: Mon, 30 Jun 2008 19:14:19 +0200
From: =?ISO-8859-1?Q?Andr=E9_Schwarz?= <Andre.Schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: MPC83xx ipic problem
References: <4868FCE9.1060103@matrix-vision.de>
	<7dd3673e01cb808007902b12a63d0399@kernel.crashing.org>
In-Reply-To: <7dd3673e01cb808007902b12a63d0399@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
	linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher,

actually I'm the hardware designer ... :-) .... having trouble with=20
software.

The outputs are open-drain and can be connected (wired-or) together.
Otherwise "shared irq" wouldn't be possible that easy.


cheers,
Andr=E9




Segher Boessenkool wrote:
>> interrupt-map =3D <0x5800 0 0 1 &ipic 0x30 0x8      -> FPGA @ IRQ0
>>                  0x6000 0 0 1 &ipic 0x11 0x8      -> miniPCI INTA @ IR=
Q1
>>                  0x6000 0 0 2 &ipic 0x11 0x8>;    -> miniPCI INTB @ IR=
Q1
>>
>> Is it legal to use a single irq pin twice ?
>
> The device tree simply describes the hardware; if the hardware
> connects both INTXs to the same IPIC interrupt pin, then it is
> correct.  You'll have to ask a hardware designer whether it is
> okay to just tie the two lines together; I believe it is, for
> PCI, but you better ask someone who really knows :-)
>
>
> Segher
>


MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht: Amtsgericht Stuttgart, HRB 271090
Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
