Message-Id: <5.1.0.14.2.20020826100602.02cea478@pop.prodigy.net>
Date: Mon, 26 Aug 2002 10:13:11 -0700
To: Hollis Blanchard <hollis@austin.ibm.com>
From: Eugene Surovegin <ebs@innocent.com>
Subject: Re: IBM 440GP 36-bit addressing
Cc: Vishwanath <vishwanath@mistralsoftware.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1030376908.1348.73.camel@granite.austin.ibm.com>
References: <001101c24b3c$ae0cca70$faffa8c0@VISHWANATH>
 <001501c24ab5$daee9500$faffa8c0@VISHWANATH>
 <1030114823.8559.37.camel@granite.austin.ibm.com>
 <001101c24b3c$ae0cca70$faffa8c0@VISHWANATH>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hollis,

At 08:48 AM 8/26/2002, you wrote:

>The usual(32-bit) way is to mmap(/dev/mem). I don't know if that will work
>with
>36-bit addresses.

It will work only for first 4G of physical address space.
/dev/mem cannot be used to access EPB/OCP or PCI address space on 440.

For this purpose "/dev/mem-like" device can be easily written that takes
into account 36-bit phys addresses.

Thanks,

  Eugene Surovegin <mailto:ebs@innocent.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
