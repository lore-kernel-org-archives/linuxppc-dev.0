Return-Path: <achim.machura@berghof.com>
Received: from pegasus.berghof.com (unknown [145.253.135.72])
	by ozlabs.org (Postfix) with ESMTP id 8A7B967A2F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Feb 2005 20:36:52 +1100 (EST)
From: "Achim Machura" <achim.machura@berghof.com>
To: "'Vijay Padiyar'" <vijay_padiyar@hotmail.com>
Date: Mon, 14 Feb 2005 10:09:01 +0100
Message-ID: <000b01c51274$d3e2ce50$34f1ff0a@BATEEE52>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <BAY1-DAV517B7CC4DBDF3A8A0BEA68B770@phx.gbl>
Cc: "Linuxppc-Embedded \(E-Mail\)" <linuxppc-embedded@ozlabs.org>
Subject: AW: some more doubts regarding memory access from user/kernel space
Reply-To: achim.machura@berghof.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Vijay,

> -----Ursprüngliche Nachricht-----
> Von: linuxppc-embedded-bounces@ozlabs.org
> [mailto:linuxppc-embedded-bounces@ozlabs.org]Im Auftrag von Vijay
> Padiyar

> with reference to my earlier mail, when do we need to use
> ioremap() and when
> do we need to use request_mem_region()? Or do we need to use both in a
> particular sequence?

I think first you have to progamm the chip select of your cpld correctly.
(see the mail from Mark)
You can do this in your module_init funktion.

Now you call request_mem_region to mark this memory used.
Now can mapp the virtual adress to your process by calling ioremap().

Regards

Achim
