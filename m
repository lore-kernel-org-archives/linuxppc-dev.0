Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8F20967A40
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Feb 2006 17:59:37 +1100 (EST)
Date: Mon, 13 Feb 2006 22:59:34 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Ed Goforth <egoforth@gmail.com>
Subject: Re: 440gx GPIO
Message-ID: <20060214065934.GA12465@gate.ebshome.net>
References: <43F168A3.4020808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43F168A3.4020808@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Feb 14, 2006 at 12:20:35AM -0500, Ed Goforth wrote:
> I am struggling with a problem and I hope someone can give me some
> pointers.  We have a custom board with a 440gx.  I need to drive GPIO11
> low.  The best as I can tell from the docs, I need to set bit 11 of the
> TCR to 1 and bit 11 of the OR to 0 to do this.

Check that this pin is enabled as GPIO not as a function pin 
(SDR0_PFC0 register).

Also, just to be sure that you remapped GPIO registers correctly, use 
ioremap64 with full physical address (not just low 32 bits).

-- 
Eugene
