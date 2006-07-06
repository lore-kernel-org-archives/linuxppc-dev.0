Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9C14E679E1
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 00:53:34 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k66ErUdk022766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Jul 2006 10:53:31 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k66ErUN2222986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Jul 2006 10:53:30 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k66ErUY5024452
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Jul 2006 10:53:30 -0400
Received: from farscape.rchland.ibm.com (farscape.rchland.ibm.com [9.10.86.73])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k66ErUlQ024413
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Jul 2006 10:53:30 -0400
Subject: G5 troubles booting powerpc-git (July 6)
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Thu, 06 Jul 2006 09:53:22 -0500
Message-Id: <1152197602.14547.10.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


        Any other G5's having troubles booting with the powerpc-git
        tree? 
        
        Mine fails..   The last text to the console is "MacIO PCI driver
        attached to Shasta chipset",  then the fans ramp up.  
        
        Booted earlier this week OK, so seems like a change in the last
        couple
        days did something bad.
        
        -Will
        
