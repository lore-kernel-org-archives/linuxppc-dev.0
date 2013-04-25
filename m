Return-Path: <chris.friesen@genband.com>
Received: from exprod7og127.obsmtp.com (exprod7og127.obsmtp.com [64.18.2.210])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 316472C00F6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 09:34:10 +1000 (EST)
Message-ID: <5179BD54.2000409@genband.com>
Date: Thu, 25 Apr 2013 17:33:40 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: why does CONFIG_NONSTATIC_KERNEL affect the boot kernel?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

Looking at the kdump code for powerpc, I see that if 
CONFIG_NONSTATIC_KERNEL is not set then the load address for the capture 
kernel is fixed at 32MB.

Why is this?

When using a separate capture kernel I don't see why that should 
restrict where I allocate space in the boot kernel.

Chris

-- 

Chris Friesen
Software Designer

500 Palladium Drive, Suite 2100
Ottawa, Ontario K2N 1C2, Canada
www.genband.com
office:+1.343.883.2717
chris.friesen@genband.com
