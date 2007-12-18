Return-Path: <rmcguire@videopresence.com>
Received: from smtpout06.prod.mesa1.secureserver.net
	(smtpout06-04.prod.mesa1.secureserver.net [64.202.165.227])
	by ozlabs.org (Postfix) with SMTP id A9EA1DDE04
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Dec 2007 10:44:14 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.543.1198006353.17691.linuxppc-embedded@ozlabs.org>
Subject: DTS files,  83xx, clock frequencies 
Date: Tue, 18 Dec 2007 15:36:29 -0800
Message-ID: <000001c841ce$d11fcdd0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.543.1198006353.17691.linuxppc-embedded@ozlabs.org>
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

All,

I note that in most of the 83xx dts config files that the different
frequency fields are being populated with non-zero numbers. i.e. bus-freq,
clock-freq, core-freq, etc...

Isn't default behavior that these fields are kept from the <BIOS> U-boot
during boot, if a zero is present? Is there any advantage to resetting them
within the dts file during linux boot up? Or is it necessary to populate
these values for correct operations, specifically with in the QUICC Engines?

Over all my curiosity is that between versions of the board, i.e. different
CPU's that may be clocked faster or slower, I see no reason to change the
dts/blobs if I already have to change the BIOS to correctly boot up.


-Russ
