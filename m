Return-Path: <mark@glines.org>
Received: from squawk.glines.org (squawk.glines.org [72.36.206.66])
	by ozlabs.org (Postfix) with ESMTP id 88074DDEEB
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Dec 2006 07:15:29 +1100 (EST)
Message-ID: <45902A6F.4000100@glines.org>
Date: Mon, 25 Dec 2006 11:45:51 -0800
From: Mark Glines <mark@glines.org>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: Linux 2.6.20-rc2: forgot how to make a zImage on powerpc?
References: <fa.ne7N9dqjDz5qS4D/fowPKdPc4ZY@ifi.uio.no>
	<fa.pM17YEcICUlveSt/vbSKGv6sFWk@ifi.uio.no>
In-Reply-To: <fa.pM17YEcICUlveSt/vbSKGv6sFWk@ifi.uio.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark Glines wrote:
> Hmm.  I'm trying to build 2.6.20-rc2 on a little powerpc box with 
> arch/powerpc/configs/linkstation_defconfig, and I get:
...
>   MODPOST vmlinux
> ln: accessing `arch/powerpc/boot/zImage': No such file or directory
> make[1]: *** [arch/powerpc/boot/zImage] Error 1
> make: *** [zImage] Error 2
> 
> So, uh, are we forgetting to go into the right subdirectory to make the 
> actual zImage, or what?  If I'm just doing something wrong, I'd love to 
> know what it is.
> 
> I'll follow up here on lkml if I diagnose this further.  Thanks,


Followup:  Yeah, it looks like it just doesn't know which format of 
zImage to produce for linkstation.

I'm not sure what image should be used by default.  I guess it depends 
on the bootloader.  Maybe default to uImage, as uBoot seems to be fairly 
common on these devices?

Mark
