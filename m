Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9BF2667A5F
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 06:00:14 +1000 (EST)
In-Reply-To: <20060425185314.GC1132@gate.ebshome.net>
References: <4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<265F73F8-F641-4EDD-B88F-A2B2F7FA1308@kernel.crashing.org>
	<20060425182418.GA1132@gate.ebshome.net>
	<200604251329.35584.bcook@bpointsys.com>
	<248CD1B3-A33B-47F5-AFE8-F7C9DDCD1D0B@kernel.crashing.org>
	<20060425185314.GC1132@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1448E56E-1327-40D5-BE44-0DC103AC3E8A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: FT u-boot shim
Date: Tue, 25 Apr 2006 15:00:05 -0500
To: Eugene Surovegin <ebs@ebshome.net>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> So, don't break compatibility if you don't have time/interest to fix
> it. We can wait till someone who "wants to move forward" can do this
> professionally without screwing everybody else.

So, lets turn this discussion into something useful (since having us  
going back and forth about our opinions isn't really going anywhere)

If we have a u-boot shim there are some questions that need answering:
* where should the .dts live (hate duplicating the file both in u- 
boot and kernel source tree)
* how does build system find .dts
* a Kconfig option to enable shim
* assume done as a boot wrapper of sorts

- kumar
