Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 800E3DDD0B
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jan 2008 02:33:47 +1100 (EST)
Message-Id: <F33FB2E0-A95F-4747-8D78-A148DFE47BCC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18330.53318.857148.409675@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: Patches added to for-2.6.25/master branches of powerpc.git
Date: Sat, 26 Jan 2008 09:33:39 -0600
References: <18330.53318.857148.409675@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 26, 2008, at 12:16 AM, Paul Mackerras wrote:

> This includes commits pulled from Josh Boyer, Kumar Gala, Grant
> Likely, and Olof Johansson.  I reverted the "Fake NUMA emulation for
> PowerPC" commit because it changed behaviour even when the fake numa
> command-line option wasn't given.
>
> I'll be asking Linus to pull within the next few days, so please
> remind me about anything else that should go in 2.6.25.
>
> Paul.

I've got a bunch of patches queued up in my tree that I'll ask you to  
pull in the next day or so.

- k
