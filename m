Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4FDB2DDEEE
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 02:53:06 +1000 (EST)
In-Reply-To: <17997.17543.725526.907770@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0705151715200.17092@localhost.localdomain>
	<17996.13115.456275.413478@cargo.ozlabs.ibm.com>
	<5F8D37B3-5A2B-49D8-A7C2-615436EA66D3@kernel.crashing.org>
	<17997.17543.725526.907770@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <20D98180-1BA9-4831-99BB-D2572976226E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch
Date: Fri, 18 May 2007 11:51:25 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 18, 2007, at 1:15 AM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> Sorry for the headache, I thought I had built an ARCH=ppc kernel.
>> This is now fixed in my tree so if you haven't pulled it you'll get
>> the fix.
>>
>> Also, added a ppc_ksysm.c fix to remove a duplicate export symbol.
>
> Hmmm.  I had pulled your tree, and I ended up rebasing your commits on
> top of Linus' current master and adding some more commits on top of
> that.  I'm about to send a pull request to Linus for that lot.  The
> arch/ppc changes can go in the next lot.

No problem, I'll merge the two patches and rebase on your latest  
tree.  We'll pull in the fixes for the MODPOST warnings as well in  
the next go around since I think Sam's __initref_ok fixes will be in  
by then.

- k
