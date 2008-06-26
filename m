Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE71ADDE25
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 18:36:54 +1000 (EST)
Message-Id: <FA8FD975-81D9-47B6-85C7-40DB2C600F04@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0806260249300.14932@blarg.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: Please pull from 'powerpc-next' branch
Date: Thu, 26 Jun 2008 03:36:45 -0500
References: <Pine.LNX.4.64.0806260249300.14932@blarg.am.freescale.net>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 26, 2008, at 2:49 AM, Kumar Gala wrote:

> Please pull from 'powerpc-next' branch of
>
> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git  
> powerpc-next
>
> to receive the following updates:


Added the kprobe patches:

Kumar Gala (2):
       powerpc/kprobes: Some minor fixes
       powerpc/booke: Add kprobes support for booke style processors


- k
