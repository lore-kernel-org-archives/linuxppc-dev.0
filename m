Return-Path: <rsmith@imagemap.com>
Received: from fileserver3.imagemap.com (mail.imagemap.com [68.156.94.66])
	by ozlabs.org (Postfix) with ESMTP id 300C767A45
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Apr 2006 04:47:23 +1000 (EST)
Received: from amavis by fileserver3.imagemap.com with scanned-ok (Exim 3.36
	#1 (Debian)) id 1FZBZ7-0001fj-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 27 Apr 2006 14:50:13 -0400
Received: from fileserver3.imagemap.com ([127.0.0.1])
	by localhost (fileserver3 [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 06200-04 for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Apr 2006 14:49:56 -0400 (EDT)
Received: from [192.168.0.196] (helo=[192.168.0.196])
	by fileserver3.imagemap.com with esmtp (Exim 3.36 #1 (Debian))
	id 1FZBYq-0001fR-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 27 Apr 2006 14:49:56 -0400
Message-ID: <4451114D.1010607@imagemap.com>
Date: Thu, 27 Apr 2006 14:45:33 -0400
From: Randy Smith <rsmith@imagemap.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re-configuring busybox that comes with DENX's ELDK SELF
References: <e2ov5s$1hn$1@sea.gmane.org> <20060426163540.H16236@cox.net>
	<20060427180743.GB11206@gate.ebshome.net>
In-Reply-To: <20060427180743.GB11206@gate.ebshome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I have a weird situation that I am very confused about and I was 
wondering if some kind soul would point me in the right direction?

I have a working powerpc embedded system using the 2.4 kernel built with 
DENX' ELDK and root file system from DENX' SELF.
I am trying to enable some additional applets in the busybox (well, tftp 
anyway) that came with SELF. I am using the ELDK cross toolchain on an 
x86 box to build everything and the powerpc board itself is based on an 
Icecube board. I thought I could do the following...

1. Download the source for busybox and compile it using the cross tools 
from DENX.
2. Install it in my target root file system
3. Make the jffs2 file system image and flash it into the unit under test.

When I do this, the kernel loads and boots just like before and then 
hangs after is says it is freeing unused memory. I am assuming that this 
is where it is trying to run the new init that I just installed, so 
obviously it isn't working like I planned.

Where did I go wrong?

I am thinking that I have a library mismatch/issue and that the new init 
binary can't/won't run with the runtime libraries that come with SELF, 
but I don't know how to go about correcting this if this is the case.

Opinions or urls to tutorials welcome.

Thanks,

-Randy Smith
Software Engineer
Imagemap, Inc.
