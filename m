Return-Path: <chris.friesen@genband.com>
Received: from exprod7og103.obsmtp.com (exprod7og103.obsmtp.com [64.18.2.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 41B8C1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 05:53:31 +1100 (EST)
Message-ID: <4ECBDE98.8090705@genband.com>
Date: Tue, 22 Nov 2011 11:40:40 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, b25806@freescale.com
Subject: curious why mpc85xx/edac/pcie patch series was never picked up
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We're doing some work with an mpc85xx-based board and someone pointed to 
a patch adding PCI/PCIE error interrupt edac support that was proposed 
by Lan Chunhe over a year ago:

http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-November/086930.html

For some reason this doesn't appear to have been picked up for mainline, 
and I'm curious why not--is there something wrong with it?

Thanks,
Chris

-- 
Chris Friesen
Software Developer
GENBAND
chris.friesen@genband.com
www.genband.com
