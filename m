Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id F288FDE00B
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 00:45:33 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: While(1) in kernel space
Date: Tue, 8 Jul 2008 16:45:31 +0200
References: <5468b7f30807080055p69571979i9a565653e523c2c0@mail.gmail.com>
	<fa686aa40807080719r4b7b01f7n7863fe1456a3e64@mail.gmail.com>
In-Reply-To: <fa686aa40807080719r4b7b01f7n7863fe1456a3e64@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807081645.31807.arnd@arndb.de>
Cc: Paolo Doz <paolo.doz@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 08 July 2008, Grant Likely wrote:

> 
> You can use a kernel thread.
> 
> I'm not sure how accurate this is, but here is some information about them:
> 
> http://www.linuxquestions.org/linux/articles/Technical/Linux_Kernel_Thread

Not accurate at all. New code should use kthread_create, as documented in

http://lwn.net/Articles/65178/

	Arnd <><
