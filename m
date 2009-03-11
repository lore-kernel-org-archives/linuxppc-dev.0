Return-Path: <mark@bish.net>
Received: from vincent.bish.net (bish.net [209.241.232.100])
	by ozlabs.org (Postfix) with ESMTP id B6162DDF1E
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 02:37:30 +1100 (EST)
Received: from www-data by vincent.bish.net with local (Exim 4.63)
	(envelope-from <mark@bish.net>) id 1LhQjS-0001SO-KA
	for linuxppc-dev@ozlabs.org; Wed, 11 Mar 2009 11:52:37 -0400
Message-ID: <20090311115234.7hmj4jj79csgk4wo@www.bish.net>
Date: Wed, 11 Mar 2009 11:52:34 -0400
From: Mark Bishop <mark@bish.net>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Subject: Freescale MPC8313ERDB-RevA and newer BSP/kernel
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Has anyone been able to get a newer Freescale BSP to work with a RevA  
(processor version 1.0) RDB?

The boards we received didn't have SPI compiled into the kernel and  
when we went to go re-compile the kernel using the 20081222 and  
20080711 BSPs.  I realize that the interrupts were reversed for eTEC1  
and eTEC2 and I've made the changes in the .dtb file and I no longer  
hang when I ping, etc.   But I still can't get the board on the  
network.  I've verified it isn't the network settings.

I've pinged Freescale for support (didn't help much) and I am now  
looking for someone who has actually done it (if ever).
