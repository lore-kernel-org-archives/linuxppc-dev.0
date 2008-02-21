Return-Path: <raul.moreno@telvent.abengoa.com>
Received: from envio.abengoa.com (envio.abengoa.com [217.15.37.68])
	by ozlabs.org (Postfix) with ESMTP id D9E4ADDE21
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 21:40:02 +1100 (EST)
In-Reply-To: <47BD1CFB.103@dlasys.lcl>
Subject: Re: initramfs problem - /init file
To: dhlii@dlasys.net
Message-ID: <OFF7D0CA65.6F1F855C-ONC12573F6.0039B07D-C12573F6.003A87F3@abengoa.com>
Date: Thu, 21 Feb 2008 11:38:52 +0100
From: raul.moreno@telvent.abengoa.com
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>







raul.moreno@telvent.abengoa.com wrote:
>> Hello everybody,
>>
>> I created a tiny root filesystem, just with Busybox, that I want to =
use
as
>> rootfs through initramfs (and keep it as the final root filesystem).=

>>
>>  Then I created an init file which is a link to
>> /sbin/init and I inserted the created cpio file with this filesystem=
 in
>> CONFIG_INITRAMFS_SOURCE.
>    The simplest way to get initramfs working is to stuff your
>root filesystem tree in a directory, and point
>    CONFIG_INITRAMFS_SOURCE at it.
>    The kernel build process will take care of all the cpio stuff
>for you.
>   Personally I think it is the easiest to maintain.


Hello Dave,

thanks for your answer. I agree with you, the easy way is to assign the=

rootfs directory. I gave the filesystem as a cpio file because it is th=
e
same (the kernel takes the rootfs and converts it to a cpio format), bu=
t
the compilation is faster. Anyway, although now I do as you said, I sti=
ll
get the error:
"Failed to execute /init
Kernel panic - not syncing: No init found.  Try passing init=3D option =
to
kernel."
I can't understand why it happens. I check the permission of /init and
/sbin/init and everything seems to me OK.

Any idea?

Ra=FAl Moreno

=
