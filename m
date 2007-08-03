Return-Path: <akostop@inaccessnetworks.com>
Received: from inaccessnetworks.com (node3.inaccessnetworks.com
	[212.205.200.118]) by ozlabs.org (Postfix) with ESMTP id 0AC04DDE19
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 00:59:06 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by inaccessnetworks.com (8.13.6/8.13.5) with ESMTP id l73Ex4cN006232
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 17:59:05 +0300
Received: from inaccessnetworks.com ([127.0.0.1])
	by localhost (host11.inaccessnetworks.com [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP id 06098-03 for <linuxppc-dev@ozlabs.org>;
	Fri,  3 Aug 2007 17:59:04 +0300 (EEST)
Received: from phoenix (phoenix.priv.inaccessnetworks.com [192.168.1.7])
	by inaccessnetworks.com (8.13.6/8.13.5) with ESMTP id l73Ex1vl006222
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 17:59:01 +0300
To: linuxppc-dev@ozlabs.org
Subject: pci in arch/powerpc vs arch/ppc
From: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-7
MIME-Version: 1.0
Date: Fri, 03 Aug 2007 17:58:56 +0300
Message-ID: <op.twhnwi18nhx3hy@phoenix>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,
in the old arch/ppc tree, there was a function called pq2ads_setup_pci()  
that set up PCI regs for 8272xx, in m82xx_pci.c. I was wandering, where  
are these registers configured now in arch/powerpc? I can't seem to find  
these code now.

Also, I can see that now bus 0, dev 0 (which I think represents the host  
bridge, right?) is now excluded using pq2_pci_exclude_device, but it  
wasn't in older code. Why is that?

thank you in advance...
