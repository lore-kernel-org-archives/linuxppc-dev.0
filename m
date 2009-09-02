Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.15])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 36CB6B7B9B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 11:19:22 +1000 (EST)
Message-ID: <4A9DC826.3010605@am.sony.com>
Date: Tue, 1 Sep 2009 18:19:34 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Lee HongWoo <hongwoo7@gmail.com>
Subject: Re: Question about linux boot procedure (head_64.S)
References: <5e2889710909010358v907022cs708dfc0dd3ed7fd0@mail.gmail.com>	
	<4A9D5A99.5030101@am.sony.com>
	<5e2889710909011725t275dcdc8oa8be58b6e32e51f4@mail.gmail.com>
In-Reply-To: <5e2889710909011725t275dcdc8oa8be58b6e32e51f4@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/01/2009 05:25 PM, Lee HongWoo wrote:
> On Wed, Sep 2, 2009 at 2:32 AM, Geoff Levand <geoffrey.levand@am.sony.com>wrote:
>> In the general case, __start is the entry point of the kernel.
>> It is where the bootloader or boot wrapper program jumps to
>> when it transfers control to the kernel.
> 
> I believe __start is the entry point of the kernel in this case.
> And the entry point is __GLOBAL(__start) in the head_64.S.
> 
> What I asked is where or what __start is called in the prom_init.c
> __start(hdr, KERNELBASE + offset, 0);

I think Michael answered this.  Just FYI, more info about the powerpc
boot is in the kernel source file:

  Documentation/powerpc/booting-without-of.txt

-Geoff
