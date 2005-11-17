Return-Path: <jaap.dejong@nedap.com>
Received: from smtp2.nedap.com (smtp2.nedap.com [213.160.213.92])
	by ozlabs.org (Postfix) with ESMTP id C491C6877F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 02:16:59 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 17 Nov 2005 16:04:49 +0100
Message-ID: <6915D0AE8B9047438F320B466AE30FDD152556@nvs0003.nedap.local>
From: "Jaap de Jong" <jaap.dejong@nedap.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: Booting hangs after "Calibrating delay loop..."
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Binh,

I am working with this fpga too, different board, same linux version,
and not very succesfull until now too...
But my build passes the "Calibrating delay loop..." and prints the
correct value!
Just guessing... perhaps your problem is timer related. Fi no timer
interrupts?

Best regards!

	Jaap de Jong



> Hi all,
>=20
> When booting Monta Vista Linux on Memec board
> (Virtex-4 FX12 LC), it hung after printing the
> following message:
>=20
>     "Calibrating delay loop..."
>
> By looking at the source code, I found that in the
> init/main.c the problem came from the
> calibrate_delay()
> function: jiffies was not incremented (jiffies was
> always equal to 0).
>
> Have anyone get the similar problem or any experience
> to fix it?
