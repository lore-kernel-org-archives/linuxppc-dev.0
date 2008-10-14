Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 676C9DDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Oct 2008 01:35:19 +1100 (EST)
Message-Id: <22A97B63-36D5-44BA-8F49-BAF5870FA08A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Mike Dyer <mike.dyer@provision-comm.com>
In-Reply-To: <48F4A8CD.6000101@provision-comm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: MPC8313E RDB: Badness at fs/sysfs/dir.c:463
Date: Tue, 14 Oct 2008 09:35:14 -0500
References: <48F49D7D.5070107@provision-comm.com>
	<48F4A8CD.6000101@provision-comm.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 14, 2008, at 9:12 AM, Mike Dyer wrote:

> Hi All,
>
> Apologies for the bad formatting of the previous message...
>
> I've just pulled the 2.6.27 kernel from git and am trying it out on  
> my MPC8313E RDB dev kit.  I get the following badness during boot  
> (the complete boot record is attached later) :

can you enable kernel symbols in your build (CONFIG_KALLSYMS)

- k
