Return-Path: <willis@arlut.utexas.edu>
Received: from ns2.arlut.utexas.edu (ns2.arlut.utexas.edu [146.6.211.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5ADB5DDECA
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Sep 2007 01:55:51 +1000 (EST)
Subject: Re: Flash paritioning and JFFS2
From: Michael Brian Willis <willis@arlut.utexas.edu>
To: Mirek23 <miroslaw.dach@psi.ch>
In-Reply-To: <12557406.post@talk.nabble.com>
References: <12293748.post@talk.nabble.com> <1187885337.5160.55.camel@louie>
	<12557406.post@talk.nabble.com>
Content-Type: text/plain
Date: Fri, 07 Sep 2007 10:55:41 -0500
Message-Id: <1189180542.4826.33.camel@louie>
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

On Fri, 2007-09-07 at 08:23 -0700, Mirek23 wrote:
>  I have the Flash memory which is CFI 
> compliant (Intel NOR Flash TE28F640 J3C120) so I presume that for it is a
> default driver?
If the flash is CFI compliant, then a default driver will probably
work. 

When the kernel boots up are you able to see a message saying that it
found your flash? You might have to play around with the kernel
configuration to get it to properly recognize your flash. 


> Do I have to create a specific file for it in drivers/mtd/maps/ ?
Yes, at least this is the way I did it. For example, I used
drivers/mtd/maps/tqm85xx.c as a starting point for my board specific
file. (I am using the DENX kernel). 


Regards, 

Michael Willis
Applied Research Labs - University of Texas
