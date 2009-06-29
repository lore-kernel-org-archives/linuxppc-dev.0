Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 838BAB7081
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 00:50:20 +1000 (EST)
Message-Id: <BD32B91E-83B3-4ED5-A5C1-60B8B6EF9B3C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "wilbur.chan" <wilbur512@gmail.com>
In-Reply-To: <e997b7420906290647g7717e55bp210f0f57d8c531c0@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: How to implement kexec on e500 ?
Date: Mon, 29 Jun 2009 09:50:13 -0500
References: <e997b7420906290647g7717e55bp210f0f57d8c531c0@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 29, 2009, at 8:47 AM, wilbur.chan wrote:

> kernel 2.6.21.7
>
> As we know , kexec stores  data  for new kernel image ,  in the form
> of   a page list.
>
> And kexec uses the physical address of the another  page for a
> "next-page" pointer.
>
> However, PowerPC e500  does not allow users to turn off the MMU, so we
> can not used physical address directly in our code.
>
>
> Someone suggested that changing  relocate_kernel.S to add a TLB 1-to-1
> mapping of DRAM .
>
> What does "mapping" mean ?
>
> Any suggestion to implement kexec on e500 ?

Wilbur, kexec has been implemented on e500.  There are some patches on  
the list for this and they just need to be respun and reviewed again.

- k
