Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EEFA4DE015
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 00:18:34 +1100 (EST)
Message-Id: <0A4216BD-1505-46DE-B08E-23E9B7E51AD2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080401175442.bf0d0c34.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] Make #include <sysdev/foo.h> work for 64-bit powerpc
Date: Tue, 1 Apr 2008 08:18:14 -0500
References: <be85035fa2cb015a8020e63b40c6d5375aaff866.1207031915.git.michael@ellerman.id.au>
	<20080401175442.bf0d0c34.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 1, 2008, at 1:54 AM, Stephen Rothwell wrote:
> Hi Michael,
>
> On Tue,  1 Apr 2008 17:39:11 +1100 (EST) Michael Ellerman <michael@ellerman.id.au 
> > wrote:
>>
>> We currently have inconsistent settings between 32 & 64-bit which  
>> means
>> 32-bit code can #include <sysdev/foo.h> but 64-bit code can't.
>
> Kumar sent a very similar (if not identical) patch earlier today.

I actually sent it several days ago, but reposted as part of the  
series of work I was doing. ;)

- k
