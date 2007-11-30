Return-Path: <stuart@quadrics.com>
Received: from quadbrsmgw.quadrics.com (quadmail.quadrics.com
	[194.202.174.130]) by ozlabs.org (Postfix) with ESMTP id 2C3B3DDE99
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Dec 2007 04:02:31 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by quadbrsmgw.quadrics.com (Postfix) with ESMTP id 31D64356D4D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Nov 2007 16:34:54 +0000 (GMT)
Received: from quadbrsmgw.quadrics.com ([127.0.0.1])
	by localhost (quadbrsmgw.quadrics.com [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id Gh5+M1Qw5xrl for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Nov 2007 16:34:41 +0000 (GMT)
Received: from exch01.quadrics.com (owa.quadrics.com [194.202.174.9])
	by quadbrsmgw.quadrics.com (Postfix) with ESMTP id 6F053356D41
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Nov 2007 16:34:41 +0000 (GMT)
Message-ID: <47503B5A.6090604@quadrics.com>
Date: Fri, 30 Nov 2007 16:33:30 +0000
From: Stuart Hodgson <stuart@quadrics.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Semaphores in eldk4.1
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

Hi,

I have been suing the eldk4.1 tool chain for a few months now and have 
not not encountered any problems with building until now. I build for 
two slightly different archs, ppc_85xx and ppx_82xx.

The problem I have come up against is related to some of the semaphore 
functions in semaphore.h, namely sem_wait, sem_post. This was originally 
noticed in a third party driver I am porting from one board to another 
but a small test program has shown the same results.

Calls to these functions on the ppc_82xx platform return -1 with an 
error code of 38, in this case meaning  ENOSYS (not implemented). On the 
ppc_85xx the same program executes fine, thus I conclude that it is 
specific to the libc-2.3.5 for ppc_82xx. Has anyone else come across 
this problem, I did find one thread but there was no conclusion listed.

I also can not find anything stating that these functions are not 
implemented for the 82xx arch compared with others for the eldk4.1

Thanks

Stuart
