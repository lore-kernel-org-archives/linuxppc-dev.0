Return-Path: <rmcguire@videopresence.com>
Received: from smtpout04-01.prod.mesa1.secureserver.net
	(smtpout04-01.prod.mesa1.secureserver.net [64.202.165.196])
	by ozlabs.org (Postfix) with SMTP id DAD40DDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Feb 2008 22:48:50 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.3.1201827605.31777.linuxppc-embedded@ozlabs.org>
Subject: 83xx immap_qe.h -> SIR type def error?
Date: Fri, 1 Feb 2008 03:47:59 -0800
Message-ID: <000001c864c8$4bd81bb0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.3.1201827605.31777.linuxppc-embedded@ozlabs.org>
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

All Freescale,

Not sure if this is the place to post this, but I have run across what I
consider to be a possible type error in the immap_qe.h file, for the
asm/powerpc branch.

In the file immap_qe.h

/* SI Routing Tables */
struct sir {
	u8  tx[0x400];
	u8  rx[0x400];
	u8  res0[0x800];
}

Shouldn't these types be defined as __be16 ?

According to the Freescale manual this is a 16 bit field, not an 8-bit
field.

Spent an hour trying to figure out why I couldn't fill this field out with
upper 8 bits last night.

Thoughts?

Russell McGuire
