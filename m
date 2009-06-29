Return-Path: <wilbur512@gmail.com>
Received: from mail-yx0-f195.google.com (mail-yx0-f195.google.com
	[209.85.210.195])
	by bilbo.ozlabs.org (Postfix) with ESMTP id D1B45B7082
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 23:47:44 +1000 (EST)
Received: by yxe33 with SMTP id 33so6901252yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 06:47:42 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 29 Jun 2009 21:47:42 +0800
Message-ID: <e997b7420906290647g7717e55bp210f0f57d8c531c0@mail.gmail.com>
Subject: How to implement kexec on e500 ?
From: "wilbur.chan" <wilbur512@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kernel 2.6.21.7

As we know , kexec stores  data  for new kernel image ,  in the form
of   a page list.

And kexec uses the physical address of the another  page for a
"next-page" pointer.

However, PowerPC e500  does not allow users to turn off the MMU, so we
can not used physical address directly in our code.


Someone suggested that changing  relocate_kernel.S to add a TLB 1-to-1
mapping of DRAM .

What does "mapping" mean ?

Any suggestion to implement kexec on e500 ?



Cheers,

wilbur
