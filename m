Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5B64EDDDE6
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 07:49:41 +1100 (EST)
Subject: Re: [PATCH 0/10] ps3av/fb drivers for 2.6.21
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0702061559420.14230@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702051624410.18405@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702061559420.14230@pademelon.sonytel.be>
Content-Type: text/plain
Date: Wed, 07 Feb 2007 07:49:13 +1100
Message-Id: <1170794953.2620.253.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> ps3av: Use a kernel thread to handle the actual video mode setting, as this
> involves some quite big delays.

The ps3 fbdev already has it's own kernel thread no ? Why use a second
one ? We could just have the ps3av code keep the delays but be called by
a thread ?

Ben.
