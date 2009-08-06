Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 22C42B6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 00:26:35 +1000 (EST)
Date: Thu, 6 Aug 2009 10:26:24 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: srikanth krishnakar <skrishnakar@gmail.com>
Subject: Re: PowerPC kernel linux-2.6.29.6 crashes at mm/slab.c for ipsec
	application
Message-ID: <20090806142624.GF8985@zod.rchland.ibm.com>
References: <6213bc560908060616m540e20e9o17a26e36662f63d8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6213bc560908060616m540e20e9o17a26e36662f63d8@mail.gmail.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 06, 2009 at 06:46:26PM +0530, srikanth krishnakar wrote:
>Hi all,
>
>Here is kernel bug for linux-2.6.29.6 for PowerPC (ppc440) target, while
>running ipsec application it is observed that kernel oops'es oftenly as show
>below :
>
>root@powerpc:~# ./ipsec
>------------[ cut here ]------------
>kernel BUG at mm/slab.c:3002!
>Oops: Exception in kernel mode, sig: 5 [#1]
>PREEMPT LTT NESTING LEVEL : 0

LTT?

>Any Clue or any bugs found in mm/slab.c for linux-2.6.29.6 while
>running IPSEC applications ?

Do you have CONFIG_PREEMPT set?  The oops output seems to think so.  Also,
seeing the LTT makes me wonder if you have added custom patches to your kernel?

Do you have a simple testcase that could be run to recreate this?  If so,
could you provide it somewhere and perhaps your .config?

josh
