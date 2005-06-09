Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id 5CC7467B39
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 00:58:31 +1000 (EST)
Date: Thu, 9 Jun 2005 07:58:28 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: scarayol@assystembrime.com
Message-ID: <20050609075828.A7242@cox.net>
References: <OFD05D82FF.63484065-ONC125701B.00332983@brime.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFD05D82FF.63484065-ONC125701B.00332983@brime.fr>;
	from scarayol@assystembrime.com on Thu, Jun 09, 2005 at
	11:30:53AM +0200
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: R?f. : Re: Read in /dev/port with Segmentation Fault
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jun 09, 2005 at 11:30:53AM +0200, scarayol@assystembrime.com wrote:
> 
> Matt,
> 
> then what is the use of /dev/port driver file ? When i do "cat /dev/port"
> on the standard console, i have also a segmentation fault.

Well, it's of no use on PPC.  It's an x86-specific driver.  It is simply
an alternative method to access x86 I/O ports. This is a hardware
construct that simply does not exist on PPC.

> Another question, if i use mmap to map physical addresses of I/O registers,
> could i dereference the pointer on virtual adresse to access data or should
> i use read/write on the file descriptor ?

Yes you can dereference, that's the point of mmaping I/O into userspace.
You may want to read Linux Device Drivers (either hardcopy or free
version online) for more details. If you google around you'll find
countless examples of people doing simple userspace driver work via
mmaped regs...those might help as a guideline.

-Matt
