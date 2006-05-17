Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (71-36-217-181.roch.qwest.net
	[71.36.217.181])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 96EB1679EA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 May 2006 12:33:15 +1000 (EST)
Subject: Re: Common Flash Interface v1.4(P30) and MTD support in
	Linux-2.4.16 kernel
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Jayasri Sangu <JayasriS@aaesys.com>
In-Reply-To: <E76D631A87C2874E895D1639A1CEDB962AF95D@aae-exchange.aaesys.com>
References: <E76D631A87C2874E895D1639A1CEDB962AF95D@aae-exchange.aaesys.com>
Content-Type: text/plain
Date: Tue, 16 May 2006 20:37:08 -0500
Message-Id: <1147829829.2512.153.camel@vader.jdub.homelinux.org>
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

On Tue, 2006-05-16 at 16:18 -0700, Jayasri Sangu wrote:
> Hi,
> 
>     Does linux-2.4.16 kernel MTD support the Intel P30 flash ?

No.  That's almost 4.5 years old now.  Intel P30 was released within the
last year.

> 
> If not what are the solutions ?

Use 2.6.15 or 2.6.16

josh
