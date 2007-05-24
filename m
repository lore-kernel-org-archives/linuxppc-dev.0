Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 1D6F5DDE30
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 03:43:41 +1000 (EST)
Message-ID: <4655CED6.5050004@mvista.com>
Date: Thu, 24 May 2007 10:43:50 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: 440 ebony patch seems to have broken 85xx build on powerpc.git
References: <4655C7A6.2050606@mvista.com>
	<1180028269.3360.21.camel@zod.rchland.ibm.com>
In-Reply-To: <1180028269.3360.21.camel@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Thu, 2007-05-24 at 10:13 -0700, Dave Jiang wrote:
>> /opt/montavista/cge/devkit/ppc/85xx/bin/../lib/gcc/powerpc-montavista-linux-gnuspe/4.2.0/include
>> -fPIC -fno-stack-protector -Iarch/powerpc/boot
>> -I/home/djiang/community/git-repos/tmp/ppc-master/arch/powerpc/boot -Wa,-mbooke
>> -c -o arch/powerpc/boot/ebony.o arch/powerpc/boot/ebony.c
>> /home/djiang/tmp/cc2UVyci.s: Assembler messages:
>> /home/djiang/tmp/cc2UVyci.s:142: Error: Unrecognized opcode: `isel'
> 
> What versions of binutils, and gcc are you using?
> 
> It seems we're going to have to start doing conditional per-file CFLAGS
> or something else if we continue to compile all the platform files in
> the bootwrapper.  I'm not too thrilled with that.
> 
> josh

gcc 4.2.0
binutils 2.17.50


-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------
