Return-Path: <jarno.manninen@tut.fi>
Received: from kivi.ton.tut.fi (kivi.ton.tut.fi [193.166.235.14])
	by ozlabs.org (Postfix) with ESMTP id 9B038679EA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Mar 2006 06:08:02 +1100 (EST)
From: Jarno Manninen <jarno.manninen@tut.fi>
To: linuxppc-embedded@ozlabs.org
Subject: Re: mpc5xxx keyboard BUG found
Date: Fri, 17 Mar 2006 20:50:01 +0200
References: <441A9FC8.3020205@fagorautomation.es>
In-Reply-To: <441A9FC8.3020205@fagorautomation.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603172050.01906.jarno.manninen@tut.fi>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 17 March 2006 13:38, Igor Luri wrote:

> We have an MPC5200LiteB board with a Microsoft USB keyboard atached and
> we have realized that some keys don't work properly, like up, down, lef
> and right arrows, PageUp, PageDown etc.

Hi!

Actually that Microsoft keyboard is working fine. A rare exception. ,-)
For more information see chapter 1.3 from here:

http://www.win.tue.nl/~aeb/linux/kbd/scancodes.html

So basically you will have to handle those in the application level code.

- Jarno
