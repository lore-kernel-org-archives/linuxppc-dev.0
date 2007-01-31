Return-Path: <rmcguire@videopresence.com>
Received: from smtpout06-04.prod.mesa1.secureserver.net
	(smtpout06-01.prod.mesa1.secureserver.net [64.202.165.224])
	by ozlabs.org (Postfix) with SMTP id 52FAADE1AC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Jan 2007 23:41:36 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.1454.1170226011.9285.linuxppc-embedded@ozlabs.org>
Subject: Audigy SE / ca0106 driver for PowerPC?
Date: Wed, 31 Jan 2007 04:14:39 -0800
Message-ID: <000601c74531$62220820$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.1454.1170226011.9285.linuxppc-embedded@ozlabs.org>
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

I recently tried to plugin and use an Audigy SE PCI card with 2.6.20 and
noticed that it would lock up during driver registration.

After a little digging, I found that the interrupt routine and a few other
functions are relying on the x86 inl() / outl() to read from the sound card.

Is anyone aware of a PPC port for this driver? Or if it would be feasible? I
haven't ported a driver between architectures before.

Or does the inl() / outl() already have PPC equivalent functions and I need
to be looking for a PCI configuration problem with my system?

-Russ
