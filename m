Return-Path: <robert@stopthespam_remove.staven.no>
Received: from merke.itea.ntnu.no (merke.itea.ntnu.no [129.241.7.61])
	by ozlabs.org (Postfix) with ESMTP id 37FD4DDEF0
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  1 Apr 2007 08:47:31 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by merke.itea.ntnu.no (Postfix) with ESMTP id EB17A13CF5B
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  1 Apr 2007 00:26:23 +0200 (CEST)
Received: from [127.0.0.1] (unknown [129.241.154.56])
	by merke.itea.ntnu.no (Postfix) with ESMTP
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  1 Apr 2007 00:26:22 +0200 (CEST)
Message-ID: <460EE00B.30007@stopthespam_remove.staven.no>
Date: Sun, 01 Apr 2007 00:26:19 +0200
From: Robert Staven <robert@stopthespam_remove.staven.no>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Allocating (placing) BufferDescriptors in Dual-Port RAM (CPM2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

It's probably basic knowledge, but I still having trouble figure it 
out.... anyway:

Working with a SCC in a CPM (MPC8250 running linux 2.6.13-AM)

I need to place Buffer Descriptors (BD) in the Dual-Port RAM (DPRAM) 
somewhere....
But two FCCs, SMC1 and SCC1 are in use, and they might use some part of 
the DPRAM.

Is there any way to figure out what part of the DPRAM thats free?
And how to reserve the part I need?

Robert

(SCC3 parameter RAM are at 0x8200 in DPRAM so I just place a struct 
there and assume that linux stays away from this memory area and don't 
get mad cause I use it without allocating it. Or have I got this wrong to?)
