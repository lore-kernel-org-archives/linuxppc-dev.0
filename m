Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5B5D867B6D
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Sep 2006 09:50:29 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8FNoQEb030050
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 19:50:26 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8FNoP34326934
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 17:50:25 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8FNoPn6013144
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 17:50:25 -0600
Date: Fri, 15 Sep 2006 18:50:25 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/4]: PowerPC: EEH: Add support for MMIO enabled recovery step
Message-ID: <20060915235025.GQ29167@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul,

Please apply and submit upstream. These patches are not urgent, 
and are mostly harmless.

The following set of patches add support for the MMIO-enabled
EEH recovery path, that is, for the path through te PCI error 
recovery code where the device driver claims it can recover 
on its own, and just wants MMIO enabled.  

Actually, the first two patches are misc EEH cleanup, 
the last two implement this function.

--linas
