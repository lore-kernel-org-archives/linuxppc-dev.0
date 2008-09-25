Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 19BC3DDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Sep 2008 13:44:47 +1000 (EST)
Received: from edison2.selinc.com (edison2.selinc.com [12.110.71.8])
	by tesla.selinc.com (8.12.11.20060308/8.12.11) with ESMTP id
	m8P3IN05004984
	for <linuxppc-embedded@ozlabs.org>; Wed, 24 Sep 2008 20:18:23 -0700
To: linuxppc-embedded@ozlabs.org
Subject: How do I access nvRAM from user space?
MIME-Version: 1.0
Message-ID: <OFFC64870C.57753273-ON882574CF.001088E7-882574CF.001228E4@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Wed, 24 Sep 2008 20:18:21 -0700
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sorry for the dumb question, I just can figure out the right google search 
to find what I'm trying to do.  I'm running 2.6.27-rc4 on an mpc8347 with 
a 32KiB nvSRAM (Cypress CY14B256L) on the local bus.  We just want to be 
able to access this memory from user space seperately from "main" memory. 
We've got a process that needs to be able to remember info through power 
cycles.  Can anyone point me to an article or some code snippet that does 
something like this so I can sink my teeth into it?

Bruce
