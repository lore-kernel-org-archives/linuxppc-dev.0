Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B19ADDFD4
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 16:59:16 +1000 (EST)
Subject: Re: [Patch ] Kexec/Kdump support - POWER6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: sachinp@in.ibm.com
In-Reply-To: <465BC5A1.5040505@in.ibm.com>
References: <4652E088.9080207@in.ibm.com> <4652E109.4020204@in.ibm.com>
	<4652E17C.7080607@in.ibm.com> <20070522153419.GA22047@lixom.net>
	<46540B6F.6030300@in.ibm.com>
	<18004.7556.311264.415721@cargo.ozlabs.ibm.com>
	<20070524121751.GB4547@in.ibm.com> <20070524142133.GA13191@lixom.net>
	<4656A488.2020507@in.ibm.com>
	<1180132987.19517.9.camel@localhost.localdomain>
	<465ABFC9.9020502@in.ibm.com>
	<1180387894.19517.99.camel@localhost.localdomain>
	<465BC5A1.5040505@in.ibm.com>
Content-Type: text/plain
Date: Tue, 29 May 2007 16:58:05 +1000
Message-Id: <1180421885.19517.109.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-29 at 11:48 +0530, Sachin P. Sant wrote:
> 
> In previous patches i had these #defines in mmu-hash64.h. But got
> review comments to move them to lpar.c :-)

Hrm... weird. Oh well, _I_ personally prefer them in mmu-hash64.h and
since I'm writing most of the MMU code lately I'd say my opinion makes
rule :-)

> Oh well i will move them back to mmu-hash64.h.

Thanks.

Cheers,
Ben.
