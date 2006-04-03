Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 826EF67A67
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 09:13:00 +1000 (EST)
In-Reply-To: <1078253E-4B9E-4432-86E3-82B01A4B68D1@kernel.crashing.org>
References: <20060403014044.GA4704@krispykreme>
	<1144080994.4449.10.camel@localhost.localdomain>
	<1078253E-4B9E-4432-86E3-82B01A4B68D1@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <58ACDA01-2AD5-494C-9325-F8FF68620491@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: _machine removal breaks kexec?
Date: Tue, 4 Apr 2006 01:16:28 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I suppose kexec needs to look for /rtas/hypertas or such ..
>
> uugh, can we make kexec not depend on something that embedded systems
> would also have.

You have embedded systems with a hypervisor?  And, a /hypertas node
even?


Segher
