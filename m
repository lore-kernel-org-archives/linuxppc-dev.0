Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AD5F7B6FAC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2012 06:33:24 +1100 (EST)
Message-ID: <4F1DB5FA.7000008@freescale.com>
Date: Mon, 23 Jan 2012 13:33:14 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "Arshad, Farrukh" <Farrukh_Arshad@mentor.com>
Subject: Re: Searching TLB entry for a page frame number.
References: <93CD5F41FDBC6042A6B449764F3B35CC050CDFE1@EU-MBX-03.mgc.mentorg.com>
In-Reply-To: <93CD5F41FDBC6042A6B449764F3B35CC050CDFE1@EU-MBX-03.mgc.mentorg.com>
Content-Type: text/plain; charset="windows-1252"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/23/2012 01:49 AM, Arshad, Farrukh wrote:
> Greetings All,
>=20
> =20
>=20
> I have a quick question regarding TLB dump for P1022. Please excuse me
> for being na=EFve. I want to dump the TLB entry for a page number. I kn=
ow
> my page frame number. If I read TLB0 dump using tlbre instruction, the
> instruction output TLB0 entries in MAS0 =96 MAS3 registers. After the
> tlbre instruction the value of MAS3 register [32-51] RPN, Is this Real
> Page Number is the page frame number for which I am searching the TLB e=
ntry.

Yes, and MAS7 contains the upper 4 bits.

-Scott
