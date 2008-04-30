Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 92038DDEEA
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 05:01:50 +1000 (EST)
Message-Id: <51A34080-7981-4958-B225-4921FC95B84A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080430113500.dfe21880.akpm@linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] docbook: fix fatal rapidio yet again (and more to come)
Date: Wed, 30 Apr 2008 14:01:12 -0500
References: <Pine.LNX.4.64.0804292009000.18219@shark.he.net>
	<20080430113500.dfe21880.akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	"Randy.Dunlap" <rdunlap@xenotime.net>,
	Paul Mackerras <paulus@samba.org>, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 30, 2008, at 1:35 PM, Andrew Morton wrote:
> On Tue, 29 Apr 2008 20:10:55 -0700 (PDT)
> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
>> From: Randy Dunlap <randy.dunlap@oracle.com>
>>
>> Don't refer to file that no longer exists:
>> docproc: linux-2.6.25-git14/arch/powerpc/kernel/rio.c: No such file  
>> or directory
>>
>> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
>> ---
>> Documentation/DocBook/rapidio.tmpl |    1 -
>> 1 file changed, 1 deletion(-)
>>
>> --- linux-2.6.25-git14.orig/Documentation/DocBook/rapidio.tmpl
>> +++ linux-2.6.25-git14/Documentation/DocBook/rapidio.tmpl
>> @@ -133,7 +133,6 @@
>> !Idrivers/rapidio/rio-sysfs.c
>>      </sect1>
>>      <sect1 id="PPC32_support"><title>PPC32 support</title>
>> -!Iarch/powerpc/kernel/rio.c
>> !Earch/powerpc/sysdev/fsl_rio.c
>> !Iarch/powerpc/sysdev/fsl_rio.c
>>      </sect1>
>
> grumble.
>
> This is a subset of rapidio-fix-docbook-references.patch, but I  
> appear to
> be unable to interest anyone in merging/reviewing/accepting/anything- 
> else
> that quite large set of patches.
>
> Guys, those patches were sent six weeks ago and it now looks like  
> they will
> miss 2.6.26.  This is pretty slack of us.  Help?

Odd.  I thought Paul had picked up a docbook RapidIO patch from you in  
the latest merge round.

- k
