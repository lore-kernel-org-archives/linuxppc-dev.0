Return-Path: <jpl@xiphos.ca>
Received: from mail.net (custpop.ca.mci.com [142.77.1.111])
	by ozlabs.org (Postfix) with ESMTP id 155BB67A7A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Apr 2005 02:56:06 +1000 (EST)
Received: from [216.95.199.148] (account jpl@xiphos.ca HELO [192.168.1.169])
	by mail.net (CommuniGate Pro SMTP 4.2.8)
	with ESMTP-TLS id 50947209 for linuxppc-embedded@ozlabs.org;
	Tue, 05 Apr 2005 11:56:05 -0400
Message-ID: <4252B50C.2080700@xiphos.ca>
Date: Tue, 05 Apr 2005 11:55:56 -0400
From: Joshua Lamorie <jpl@xiphos.ca>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Recommendations: Small Embedded PPC chip with FPU
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Gidday there,

I am looking for a new PowerPC for some controls applications and I was 
wondering if anyone on this list might make some recommendations.  I 
will be fabricating the board, so I'm just interested in the CPU.  
Currently I'm doing everything on a Virtex-II Pro (PPC 405).

I'm considering the MPC5200, but I would love to have something in a 
smaller package.

Requirements:
    - Linux support
    - PowerPC w >= 16k D,I Cache
    - FPU
    - Onboard memory controller (SDRAM or DDR)
    - >= 300 MHz
    - Industrial temperature (-40 to +85)
    - package size < 27mmx27mm
    - everything else is icing

Any suggestions welcome.

I'm sorry if this is somewhat off topic.

Joshua

-- 

Xiphos Technologies
(514) 848-9640 x227
(514) 848-9644 fax

www.xiplink.com
_______________________________________________
The information transmitted is intended only for the
person or entity to which it is addressed and may contain
confidential and/or privileged material.  If you have
received this in error, please contact the sender and delete
this communication and any copy immediately. Thank you.
