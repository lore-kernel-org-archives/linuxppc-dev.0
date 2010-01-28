Return-Path: <john.williams@petalogix.com>
MIME-Version: 1.0
Date: Thu, 28 Jan 2010 17:13:00 +1000
Message-ID: <1d3f23371001272313i62fc9158se4cd9173f196fb12@mail.gmail.com>
Subject: UIO / of_genirq driver
From: John Williams <john.williams@petalogix.com>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: gregkh@suse.de, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	hjk@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I came across this thread/patchset from around June last year:

http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/073086.html

where Wolfgang proposed a generic OF-driven UIO driver.  The
discussion seemed to stall after Grant Likely indicated he didn't like
the use of a linux-specific compatible binding in the device tree
(compatible="generic-uio").

I guess I have a couple of questions:

 * did this patchset go anywhere?  I've been using it here the last
few days and it works great.

and more generally:

 * Is there a better way to handle the OF bindings for this sort of thing?

Grant's complaint seems to come up often - when you have generic
controllers in a system (SPI/I2C also spring to mind), we need a way
of signalling somehow to the kernel that each instance has a
particular usage intended.

However, the device-tree guys complain whenever anyone tries to encode
anything non-hardware related into the DTS itself.

I guess I'd like to just open up a discussion, see if there's been any
progress towards a general solution.

Thanks,

John
-- 
John Williams
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com  p: +61-7-30090663  f: +61-7-30090663
