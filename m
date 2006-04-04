Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EE21467B17
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 10:43:38 +1000 (EST)
In-Reply-To: <58ACDA01-2AD5-494C-9325-F8FF68620491@kernel.crashing.org>
References: <20060403014044.GA4704@krispykreme>
	<1144080994.4449.10.camel@localhost.localdomain>
	<1078253E-4B9E-4432-86E3-82B01A4B68D1@kernel.crashing.org>
	<58ACDA01-2AD5-494C-9325-F8FF68620491@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <786624E0-4489-49AD-8ACE-4A2AAF518DF3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: _machine removal breaks kexec?
Date: Mon, 3 Apr 2006 19:43:58 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 3, 2006, at 6:16 PM, Segher Boessenkool wrote:

>>> I suppose kexec needs to look for /rtas/hypertas or such ..
>>
>> uugh, can we make kexec not depend on something that embedded systems
>> would also have.
>
> You have embedded systems with a hypervisor?  And, a /hypertas node
> even?

no and no.  However, I dont see any reason kexec should be available  
on embedded PPCs.

- k
