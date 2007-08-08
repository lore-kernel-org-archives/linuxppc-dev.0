Return-Path: <jyoung5@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B1014DDE99
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 04:45:14 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78IjAo1020746
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:45:10 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78IjAhw521998
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:45:10 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78IjARc018547
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:45:10 -0400
Subject: Sequoia 440EPx patches not working
From: Jerone Young <jyoung5@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 08 Aug 2007 13:45:10 -0500
Message-Id: <1186598710.5459.7.camel@laptop>
Mime-Version: 1.0
Cc: vbarshark@ru.mvista.com
Reply-To: jyoung5@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Using the Sequoia (AMCC 440EPx) patches recently submitted to the list I
am unable to boot to fully boot a uImage built with these patches under
Uboot. It appears to hang in very early boot.


Here is the output:
=> tftp 400000 sequoia/uImage                                                   
ENET Speed is 100 Mbps - FULL duplex connection (EMAC0)                         
Using ppc_4xx_eth0 device                                                       
TFTP from server 9.53.41.24; our IP address is 9.53.41.38                       
Filename 'sequoia/uImage'.                                                      
Load address: 0x400000                                                          
Loading: #################################################################      
         #################################################################      
         #################################################################      
         #######################                                                
done                                                                            
Bytes transferred = 1112434 (10f972 hex)                                        
=> bootm 400000                                                                 
## Booting image at 00400000 ...                                                
   Image Name:   Linux-2.6.23-rc2                                               
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)                   
   Data Size:    1112370 Bytes =  1.1 MB                                        
   Load Address: 00000000                                                       
   Entry Point:  00000000                                                       
   Verifying Checksum ... OK                                                    
   Uncompressing Kernel Image ... OK 
