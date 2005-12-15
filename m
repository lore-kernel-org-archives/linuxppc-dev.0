Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B25486884E
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Dec 2005 02:47:02 +1100 (EST)
In-Reply-To: <1134655801.5787.1.camel@localhost>
References: <1134569118.3875.9.camel@localhost>
	<17312.38814.551675.906916@cargo.ozlabs.ibm.com>
	<4590.131.234.232.31.1134639886.squirrel@secure.sipsolutions.net>
	<44B795CA-E338-4AAC-937D-F2EEA5E27EB9@kernel.crashing.org>
	<1134655801.5787.1.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B0D05C13-19AC-42A8-9D26-30B142B07441@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 15 Dec 2005 09:47:05 -0600
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: illegal instructions / irqs disabled warning
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 15, 2005, at 8:10 AM, Johannes Berg wrote:

> On Do, 2005-12-15 at 08:04 -0600, Kumar Gala wrote:
>
>> Out of interest, is there a reason you dont handle the emulation in
>> user space?
>
> I'm not even interested in emulating that at all, the kernel just
> checked if it could emulate it (couldn't, so my program died with
> SIGILL)...
> To tell the truth, I was just testing what would happen and wrote a
> buggy program.

Ahh, you should check out LTP its got some tests like this which  
generate random instruction images and see what happens.  Helps  
finding kernel bugs.

- kumar
