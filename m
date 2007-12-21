Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3CEECDDE02
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 02:29:38 +1100 (EST)
Message-Id: <CED04DA2-D9C2-4F25-80D1-FC2D6170BF05@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Marian Balakowicz <m8@semihalf.com>
In-Reply-To: <476BCA09.3070104@semihalf.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: Yet more patches added to for-2.6.25/master branches
Date: Fri, 21 Dec 2007 09:29:32 -0600
References: <18283.44454.618519.155696@cargo.ozlabs.ibm.com>
	<476BCA09.3070104@semihalf.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 21, 2007, at 8:13 AM, Marian Balakowicz wrote:

>
> Any changes to add new 52xx targets:
>
> http://patchwork.ozlabs.org/linuxppc/patch?person=988&id=14661
> http://patchwork.ozlabs.org/linuxppc/patch?person=988&id=14662
> http://patchwork.ozlabs.org/linuxppc/patch?person=988&id=14663
> http://patchwork.ozlabs.org/linuxppc/patch?person=988&id=14743
> http://patchwork.ozlabs.org/linuxppc/patch?person=988&id=14665
> http://patchwork.ozlabs.org/linuxppc/patch?person=988&id=14666
> http://patchwork.ozlabs.org/linuxppc/patch?person=988&id=14667
> http://patchwork.ozlabs.org/linuxppc/patch?person=988&id=14668
> http://patchwork.ozlabs.org/linuxppc/patch?person=988&id=14669
> http://patchwork.ozlabs.org/linuxppc/patch?person=988&id=14670
> http://patchwork.ozlabs.org/linuxppc/patch?person=988&id=14671
> http://patchwork.ozlabs.org/linuxppc/patch?person=988&id=14672
> http://patchwork.ozlabs.org/linuxppc/patch?person=988&id=14673
>
> Those did not make it to 2.6.24, Grant Likely suggested to wait until
> 2.6.25 window opens.

A few of these patches may need to get updated do to other changes.   
For example the i2c nodes in .dts.

- k
