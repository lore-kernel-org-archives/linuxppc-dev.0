Return-Path: <Frank_Rowand@sonyusa.com>
Received: from VA3EHSOBE001.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id D0C48DDF02
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 10:22:28 +1100 (EST)
Message-ID: <49823A13.50703@am.sony.com>
Date: Thu, 29 Jan 2009 15:21:55 -0800
From: Frank Rowand <frank.rowand@am.sony.com>
MIME-Version: 1.0
To: Steven Rostedt <srostedt@redhat.com>
Subject: Re: 2.6.28-rt on PowerPC
References: <20090129213429.GA29014@oksana.dev.rtsoft.ru>
	<1233270043.3833.57.camel@localhost.localdomain>
In-Reply-To: <1233270043.3833.57.camel@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
Reply-To: frank.rowand@am.sony.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Steven Rostedt wrote:
> On Fri, 2009-01-30 at 00:34 +0300, Anton Vorontsov wrote:
>> Hi Steven,
>>
>> I know 2.6.28-rt isn't yet ready, but I could not resist to try
>> it anyway. ;-)
>>
>> Here are few issues and ways to solve them:
>>
>> Currently the -rt tree doesn't link for arch/powerpc:
>>
>>   LD      .tmp_vmlinux1
>>   arch/powerpc/kernel/built-in.o: In function `show_interrupts':
>>   (.text+0x27bc): undefined reference to `__call_bad_lock_func'
>>   arch/powerpc/kernel/built-in.o: In function `show_interrupts':
>>   (.text+0x28b0): undefined reference to `__call_bad_lock_func'
>>   make: *** [.tmp_vmlinux1] Error 1
> 
> Thanks! I have not yet had the chance to apply any arch patches yet. I
> do plan on doing so after getting the code mostly working on x86.

Your email can at an opportune time for me...  I was starting to try
2.6.28-rt on ARM and quickly came to the conclusion that the arch
patches weren't the focus yet.  But I'm currently side-tracked with
getting my board to even boot a vanilla 2.6.28 kernel first.  Do
you expect to get to the arches in the next week or two?  If not,
I may head down that path for ARM myself.

Thanks!

-Frank Rowand
