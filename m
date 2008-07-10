Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D5C9EDDEF8
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 23:25:10 +1000 (EST)
Message-Id: <27E74D0C-8395-4176-86D9-0CC38027D95F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080710031305.0ccede72.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: Please pull from 'powerpc-next' branch
Date: Thu, 10 Jul 2008 08:24:53 -0500
References: <Pine.LNX.4.64.0807090812110.6382@blarg.am.freescale.net>
	<20080710031305.0ccede72.sfr@canb.auug.org.au>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 9, 2008, at 12:13 PM, Stephen Rothwell wrote:

> Hi Kumar,
>
> On Wed, 9 Jul 2008 08:13:03 -0500 (CDT) Kumar Gala <galak@kernel.crashing.org 
> > wrote:
>>
>> Please pull from 'powerpc-next' branch of
>>
>> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/dts.git powerpc- 
>> next
>
> $ git ls-remote ssh://master.kernel.org/pub/scm/linux/kernel/git/galak/dts.git
> fatal: '/pub/scm/linux/kernel/git/galak/dts.git': unable to chdir or  
> not a git archive
> fatal: The remote end hung up unexpectedly
>
> Did you mean ".../powerpc.git"?

yes.  the script I use was run from the wrong dir.

> Also, the master branch of that tree has the same problem I came up
> against in linux-next today: include/asm-powerpc/pgtable-ppc64.h
> mismerges between Linus' tree and the Paul's tree so you end up with  
> two
> copies of huge_ptep_set_wrprotect.  So you should amend the merge to
> remove one.

Thanks, will fix up by hand.

- k
