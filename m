Return-Path: <susheel.nuguru@mitron.fi>
Received: from mitron.mitron.fi (mail.mitron.fi [82.116.252.3])
	by ozlabs.org (Postfix) with ESMTP id AFE7D681DB
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Sep 2005 21:19:12 +1000 (EST)
From: Nuguru Susheel <susheel.nuguru@mitron.fi>
To: zhonglei@RCS-9000.COM
Content-Type: text/plain
Date: Wed, 07 Sep 2005 14:21:50 +0000
Message-Id: <1126102910.14131.24.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How can I compile the module into kernel
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Zhonglei,

 after your kernel boots up and you have command line on ur console
type 
"insmod htm.o" for normal insertion, if anything goes wrong try to force
"insmod -f htm.o"

forcing option is not recommended .. go through these pages
http://www.tldp.org/LDP/lkmpg/

> My driver is a char device driver htm.o. How can I compile it into my kernel?
