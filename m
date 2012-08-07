Return-Path: <B04825@freescale.com>
Message-ID: <50217CFA.7040708@freescale.com>
Date: Tue, 7 Aug 2012 15:39:22 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: <devicetree-discuss@lists.ozlabs.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Endianness of multi-bit 'gpios' property?
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a 'gpios' property defines multiple GPIO pins, is there any kind of
expectation on the endian order of those pins?  For example, take this:

	gpios = <&gpio0 0 0
		 &gpio0 1 0>;

If I write a value of "2" to this GPIO pair, should I expect a value of 1
to be written to pin 0 and a value of 0 written to pin 1 (i.e.
big-endian), or the other way around?

I'm seeing some code that interprets the bits as big-endian, and some code
that interprets it as little-endian.

-- 
Timur Tabi
Linux kernel developer at Freescale
