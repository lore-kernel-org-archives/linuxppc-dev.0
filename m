Return-Path: <vijay_padiyar@hotmail.com>
Received: from hotmail.com (bay1-dav5.bay1.hotmail.com [65.54.244.109])
	by ozlabs.org (Postfix) with ESMTP id D796167A67
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Feb 2005 02:15:03 +1100 (EST)
Message-ID: <BAY1-DAV517B7CC4DBDF3A8A0BEA68B770@phx.gbl>
From: "Vijay Padiyar" <vijay_padiyar@hotmail.com>
To: "Embedded TUX" <etux@embeddedtux.org>,
	"LinuxPPC Support" <linuxppc-embedded@ozlabs.org>
Date: Fri, 11 Feb 2005 20:45:47 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: some more doubts regarding memory access from user/kernel space
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

Some more doubts about the same thing.

As I am aware, the MPC8260 does not have a separate I/O address space. So,
with reference to my earlier mail, when do we need to use ioremap() and when
do we need to use request_mem_region()? Or do we need to use both in a
particular sequence?

Also, if I just do an ioremap(), can I directly access those remapped
addresses with inb()/outb() or writeb()/readb()? Or is something more to be
done prior to accessing it?

Regards

Vijay Padiyar

http://www.vijaypadiyar.eu.tf
