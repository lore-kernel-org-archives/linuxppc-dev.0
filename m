Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5894B67A64
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Apr 2005 04:32:49 +1000 (EST)
In-Reply-To: <Pine.LNX.4.61.0504081010330.14089@localhost.localdomain>
References: <Pine.LNX.4.61.0504081010330.14089@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e6dbd8188d62839f349bec5a4cd0b352@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 8 Apr 2005 14:32:44 -0400
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: cross-compiling under cygwin?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 8, 2005, at 10:13 AM, Robert P. J. Day wrote:

>   i've just had a request from a colleague who wants to do all the
> cross-compilation for our 8xx board on a windows box, rather than
> linux.

Just remember there is lots more to building and developing
than compiling a kernel.  In addition to the compiler, you need
lots of support tools.  Once you get a kernel, you have to create
some kind of file system, of course NFS won't work on Windows,
creating a ramdisk without a loopback device and file system
support is quite a challenge, too.

I don't understand why you wouldn't want to develop on a
Linux (or at least Unix) host, since you need those skills
and environment for the target.  Do they just like impossible
challenges in their way to getting real work done? :-)


	-- Dan
