Return-Path: <dmytro.bablinyuk@rftechnology.com.au>
Received: from host.our-web-host.com (host.our-web-host.com [209.239.36.67])
	by ozlabs.org (Postfix) with ESMTP id 7575F67E88
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Aug 2005 15:14:34 +1000 (EST)
Received: from [192.168.1.3] ([61.68.6.214])
	by host.our-web-host.com (8.12.10/8.12.10) with ESMTP id j7F4sPB5017549
	for <linuxppc-embedded@ozlabs.org>; Mon, 15 Aug 2005 00:54:26 -0400
Message-ID: <43001FFE.2040605@rftechnology.com.au>
Date: Mon, 15 Aug 2005 14:54:22 +1000
From: Dmytro Bablinyuk <dmytro.bablinyuk@rftechnology.com.au>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: low latency/preempt patch for denx linuxppc_2_4_devel
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I hope this is the right place to ask. My apologise if it's wrong.
I am using linuxppc_2_4_devel from denx.de (2.4.25 PPC oriented patched 
kernel) and looking at the code I didn't find any low latency/preempt 
patches (well this is still a 2.4.x kernel, so no problem) so I went to 
the internet and found 2.4.25-low-latency.patch.gz (that is fails to 
apply at one file anyway) but I couldn't find preemptible patch for this 
version of kernel.
I found preempt-kernel-rml-2.4.23-pre5-1.patch and 
preempt-kernel-rml-2.4.26-pre5-1.patch which are pretty close but not 
exactly for the same version.

Is anybody using linux_2_4_devel from denx.de for 'soft' real-time 
embedded targets?

Thank you

Dmytro
