Return-Path: <chris.friesen@genband.com>
Received: from exprod7og123.obsmtp.com (exprod7og123.obsmtp.com [64.18.2.24])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1F4B02C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 01:45:42 +1000 (EST)
Message-ID: <5166DA49.5000907@genband.com>
Date: Thu, 11 Apr 2013 09:44:09 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: recommended method of netbooting kernel/dtb in u-boot?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi all,

We've got a powerpc system that uses u-boot.  In our environment on 
bootup u-boot does a DHCP to get networking info, then uses TFTP to get 
the kernel, which then does DHCP again and NFS-mounts the initial root 
filesystem.

What's the standard practice for this sort of thing when using device 
tree blobs?  Do most people use multi-file images or do they TFTP 
scripts to load and execute separate kernel/dtb files?

For multi-part images is there an in-kernel way of generating a file 
containing a kernel and dtb combined?  I saw a patch proposed in 2008 to 
add a uImage.<dt> build target but it was shot down because it used the 
legacy multi-file format.  Is there an equivalent build target that uses 
the FIT format?

Chris

-- 

Chris Friesen
Software Designer

500 Palladium Drive, Suite 2100
Ottawa, Ontario K2N 1C2, Canada
www.genband.com
office:+1.343.883.2717
chris.friesen@genband.com
