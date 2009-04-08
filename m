Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 23513DDFF2
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 01:21:59 +1000 (EST)
Message-Id: <BAE2DC43-2222-4353-BFA7-91A25ACD280F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20090408144845.GA29163@lixom.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: any place to mark various compatible strings as deprecated?
Date: Wed, 8 Apr 2009 10:21:54 -0500
References: <84DDF2F3-F907-4131-8C41-A9156BD5ADB2@kernel.crashing.org>
	<20090408144845.GA29163@lixom.net>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 8, 2009, at 9:48 AM, Olof Johansson wrote:

> On Wed, Apr 08, 2009 at 09:23:22AM -0500, Kumar Gala wrote:
>> Do we have anywhere to list out compatible strings that are  
>> deprecated
>> and warn if the kernel sees one?
>
> Wouldn't dtc be a better location for that? The kernel has to be  
> backwards
> compatible anyway, I don't really see a reason to warn there.

The reason is I want to eventually drop support in the kernel for some  
of the old compatibles.

- k
