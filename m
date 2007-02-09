Return-Path: <s.magistrali@selta.it>
Received: from seltapc_wus.selta-spa.local (mail.selta.it [88.33.125.115])
	by ozlabs.org (Postfix) with SMTP id 3AA94DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Feb 2007 21:14:07 +1100 (EST)
Received: from SELTAPC_EX1.selta-spa.local ([10.10.0.22])
	by seltapc_wus.selta-spa.local (SMSSMTP 4.1.9.35) with SMTP id
	M2007020910585604562
	for <linuxppc-embedded@ozlabs.org>; Fri, 09 Feb 2007 10:58:56 +0100
Message-ID: <45CC45C4.6070501@selta.it>
Date: Fri, 09 Feb 2007 10:58:28 +0100
From: stefania magistrali <s.magistrali@selta.it>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org.
Subject: question about m8260_cpm_hostalloc
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

Hi!
I am using the m8260_cpm_hostalloc function. My question is: does this 
function return cached or uncached memory?  Instead I think that the 
m8xx_cpm_hostalloc function gives back uncached memory.  If so, why this 
difference?
I need to have uncached memory, so I would like to be sure about using 
m8260_cpm_hostalloc function.
Thanks very much!
Stefania
