Return-Path: <jdub@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C9DB067BA9
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Sep 2006 00:48:19 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k87EmGlb020357
	for <linuxppc-embedded@ozlabs.org>; Thu, 7 Sep 2006 10:48:16 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k87EmGpP278046
	for <linuxppc-embedded@ozlabs.org>; Thu, 7 Sep 2006 08:48:16 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k87EmF82015284
	for <linuxppc-embedded@ozlabs.org>; Thu, 7 Sep 2006 08:48:16 -0600
Subject: Re: What is this "flat device tree"
From: Josh Boyer <jdub@us.ibm.com>
To: Alex Zeffertt <ajz@cambridgebroadband.com>
In-Reply-To: <45002E72.8080608@cambridgebroadband.com>
References: <45002E72.8080608@cambridgebroadband.com>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 09:49:45 -0500
Message-Id: <1157640585.6098.52.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2006-09-07 at 15:36 +0100, Alex Zeffertt wrote:
> Can anybody explain to me what the "flat device tree" is?  The phrase comes up 
> often but I can't find a definition for it anywhere on the web.

See Documentation/powerpc/booting-without-of.txt in the kernel tree.

It's basically a representation of an Open Firmware device tree that has
been flattened and given to the kernel when it boots.  For platforms
without Open Firmware, it needs to be constructed by the boot loader, or
using the Device Tree Compiler (DTC).

josh
