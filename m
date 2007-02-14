Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19383DDE37
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 09:53:53 +1100 (EST)
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <45D385E9.4020808@freescale.com>
References: <1171409687840-git-send-email-timur@freescale.com>
	<1171411075.20192.116.camel@localhost.localdomain>
	<45D29AE5.7090004@freescale.com>
	<1171430877.20192.133.camel@localhost.localdomain>
	<45D29EB1.5060801@freescale.com>
	<1171431334.20192.138.camel@localhost.localdomain>
	<45D316CD.9070901@freescale.com>
	<1171486473.20192.147.camel@localhost.localdomain>
	<45D378F4.3040003@freescale.com>
	<1171487822.20192.163.camel@localhost.localdomain>
	<45D385E9.4020808@freescale.com>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 09:53:42 +1100
Message-Id: <1171493623.20192.188.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Of course, the real solution to this problem is to fix U-Boot. 

Yup :-)

>  However, there 
> isn't any signed up to do that, and even if someone posted a patch right now, 
> there's no telling when it will get applied.  And even if it got applied today, 
> all current U-Boot installations would be broken.  Many of these systems will 
> never be updated.

But their .dts neither so it doesn't matter does it ?

> Therefore, I would say that having a 'chosen' node in the DTS is actually a 
> *bad* thing, on systems that use U-Boot.

Too bad for them..

> Another work-around would be to update the compiler to delete the chosen node 
> when it builds the DTB.  That's not a bad idea, I think, but until that feature 
> is implemented, the DTS files should not have a 'chosen' node.

Ben.
