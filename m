Return-Path: <asierra@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBEC51A003B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 02:24:05 +1000 (EST)
Date: Wed, 20 Aug 2014 11:21:56 -0500 (CDT)
From: Aaron Sierra <asierra@xes-inc.com>
To: Gokul C G <gokul.g@kalkitech.in>
Message-ID: <1589883448.38884.1408551716508.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <53F3629A.6060208@kalkitech.in>
References: <53F3629A.6060208@kalkitech.in>
Subject: Re: PCIe driver not working properly after upgrading to linux 3.8.13
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: meta-freescale@yoctoproject.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, djiang@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

----- Original Message -----
> From: "Gokul C G" <gokul.g@kalkitech.in>
> Sent: Tuesday, August 19, 2014 9:43:38 AM
> 
> HI,
> 
> I am facing problem with PCIE driver in new Linux kernel compiled for powerpc
> architecture (Big endian) ,freescales P2040 processor.I was using old kernel
> Linux version 3.0.48 previously and now updated to Linux version
> 3.8.13-rt9.After updating to the new kernel, PCIe device drivers not working
> properly and i am getting some error messages in the boot-up .My intention
> is to use EXAR PCIe Multiport serial driver and add 8 serial ports in
> addition to 4 built in serial ports provided by P2040 processor. The PCIe
> driver form EXAR is compiled and loaded as kernel module . The same was
> working with linux kernel 3.0.48 and following prints observed while loading
> kernel module.
> 

Have you attempted to use the XR17V35x support present in the updated version
of the kernel that you're using (I assume it's Freescale SDK 1.4.x)?

8250 core support for Exar parts:
http://git.freescale.com/git/cgit.cgi/ppc/sdk/linux.git/tree/drivers/tty/serial/8250/8250.c?h=sdk-v.1.4.x#n296

PCI vendor and device IDs for 2, 4 and 8 port Exar parts:
http://git.freescale.com/git/cgit.cgi/ppc/sdk/linux.git/tree/drivers/tty/serial/8250/8250_pci.c?h=sdk-v.1.4.x#n1722

-Aaron
