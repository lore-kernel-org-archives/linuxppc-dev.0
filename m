Return-Path: <rientjes@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.33.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6496EDDD01
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 10:07:12 +1100 (EST)
Date: Fri, 7 Dec 2007 15:06:55 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC
In-Reply-To: <20071207212817.GA391@lixom.net>
Message-ID: <alpine.DEB.0.9999.0712071505100.27689@chino.kir.corp.google.com>
References: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
	<20071207212817.GA391@lixom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 7 Dec 2007, Olof Johansson wrote:

> > Comments are as always welcome!
> 
> Care to explain what this is useful for? (Not saying it's a stupid idea,
> just wondering what the reason for doing it is).
> 

Fake NUMA has always been useful for testing NUMA code without having to 
have a wide range of hardware available to you.  It's a clever tool on 
x86_64 intended for kernel developers that simply makes it easier to test 
code and adds an increased level of robustness to the kernel.  I think 
it's a valuable addition.
