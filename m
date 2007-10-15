Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id D3AACDDFC2
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 02:08:46 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2169605wag
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 09:08:45 -0700 (PDT)
Message-ID: <fa686aa40710150908o55d1f5d2t264cbb8ed800a12f@mail.gmail.com>
Date: Mon, 15 Oct 2007 10:08:44 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, microblaze-uclinux@itee.uq.edu.au
Subject: Refactor booting-without-of.txt
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adding the Linux expected device tree bindings to
booting-without-of.txt seems to be getting a little unwieldy.  Plus
with more than one arch using the device tree (powerpc, sparc &
microblaze) the device tree bindings aren't necessarily powerpc only
(the Xilinx devices certainly fall in this category).

Anyone have comments about splitting the expected device tree bindings
out of booting-without-of.txt into a separate directory?

Perhaps something like this; each file contains common bindings for
the type of device and device specific properties:

Documentation/of/
Documentation/of/README - Description of the purpose and layout of
this directory
Documentation/of/net.txt - network device bindings (eth, MDIO, phy, etc)
Documentation/of/serial.txt - serial device bindings
Documentation/of/misc.txt - anything that doesn't fit anywhere else yet.
Documentation/of/soc/* - System on chip stuff that doesn't fit will
into established device types; possibly a separate file for each chip.
Documentation/of/usb.txt - usb blah blah blah
Documentation/of/whatever - you get the picture.

Thoughts?
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
