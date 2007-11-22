Return-Path: <bheemappa@rasstechnologies.com>
Received: from server.urmail.net (server.urmail.net [70.86.28.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E282DDE1A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Nov 2007 17:13:50 +1100 (EST)
Received: from [59.96.20.203] (helo=ashraya.int)
	by server.urmail.net with esmtpa (Exim 4.66)
	(envelope-from <bheemappa@rasstechnologies.com>) id 1Iv5Kf-0001cU-DT
	for linuxppc-embedded@ozlabs.org; Thu, 22 Nov 2007 00:14:42 -0600
Received: from WorldClient ([127.0.0.1])
	(authenticated user bheemappa@ashraya.int)
	by ashraya.int (ashraya.int [192.168.50.1]) (MDaemon.PRO.v6.8.4.R)
	with ESMTP id 47-md50000000004.tmp
	for <linuxppc-embedded@ozlabs.org>; Thu, 22 Nov 2007 11:41:48 +0530
Date: Thu, 22 Nov 2007 11:41:48 +0530
From: "Bheemappa" <bheemappa@rasstechnologies.com>
To: linuxppc-embedded@ozlabs.org
Subject: #PPC: timeout while waiting for freeze
Message-ID: <WorldClient-F200711221141.AA41480003@ashraya.int>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



 

Hello
      I am using BDI2000 debugger to debug our custom board which has 
MPC7457 processor and Marvell's discovery-ii(MV64360) as host bridge. I 
have 
connectd target board to BDI using JTAG.I am getting the BDI prompt and 
also its reading PVR number correctly, but when I am  trying to access 
any memory location i.e 0xf1000000 using below command its giving below 
error.



BDI> md 0xf1000000
#PPC: timeout while waiting for freeze

  Why this error is coming ? , can you give us more detailed description
for this error message , so that we can trace the source of error mssage.
Below is my mail id plz send any suggestions.

 bheemappa@rasstechnologies.com

 Regards
 Bheema
 RASS Tech Pvt Ltd
 Bangalore
