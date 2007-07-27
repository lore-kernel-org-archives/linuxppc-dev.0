Return-Path: <akostop@inaccessnetworks.com>
Received: from inaccessnetworks.com (node3.inaccessnetworks.com
	[212.205.200.118]) by ozlabs.org (Postfix) with ESMTP id A2378DDE27
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 22:24:22 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by inaccessnetworks.com (8.13.6/8.13.5) with ESMTP id l6RCOJlW016362
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 15:24:19 +0300
Received: from inaccessnetworks.com ([127.0.0.1])
	by localhost (host11.inaccessnetworks.com [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP id 15942-12 for <linuxppc-dev@ozlabs.org>;
	Fri, 27 Jul 2007 15:24:18 +0300 (EEST)
Received: from phoenix (phoenix.priv.inaccessnetworks.com [192.168.1.7])
	by inaccessnetworks.com (8.13.6/8.13.5) with ESMTP id l6RCODro016355
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 15:24:13 +0300
Date: Fri, 27 Jul 2007 15:24:08 +0300
To: linuxppc-dev@ozlabs.org
Subject: pq2fads support...
From: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-7
MIME-Version: 1.0
Message-ID: <op.tv4h01apnhx3hy@phoenix>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Scott and all,

In your patch for the pq2fads support, the device tree seems to be missing  
a memory node, for which dtc complains loudly. Is this board tested to  
boot with these patches (because I'm now using this as a template for my  
board - with your patchset applied to Paul's git)

thanks a lot

Alex

PS. What's about this new cpm-serial driver? is this supposed to be a  
replacement for cpm_uart?
