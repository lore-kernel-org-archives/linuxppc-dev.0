Return-Path: <bwarren@qstreams.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id 46B8B67C88
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 03:53:19 +1000 (EST)
Subject: Platform device style question
From: Ben Warren <bwarren@qstreams.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Thu, 24 Aug 2006 13:53:17 -0400
Message-Id: <1156441997.17977.44.camel@saruman.qstreams.net>
Mime-Version: 1.0
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

A 'newbie-to-platform-devices' question:

In a patch that Kumar just sent for a compact flash device, the resource
data (I/O addresses, IRQ # etc.) are retrieved from the platform system.
I guess I can either modify the device tree in U-boot by adding
additional nodes, or instantiate a platform device in Linux __init code
based on static information.  The former gives the advantage of having
the bootloader pass the info to the OS.  (Somebody please correct me if
I'm off-base here!)  

Are device trees meant to only contain information about the CPU and
tightly-coupled peripherals, or is it considered OK-form to also include
board-level hardware info?  I guess they can really hold anything, but
I'm trying to figure out the original intent.

regards,
Ben
