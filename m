Message-ID: <3B97C6D2.3040904@brocade.com>
Date: Thu, 06 Sep 2001 11:56:18 -0700
From: Amit D Chaudhary <amitc@brocade.com>
MIME-Version: 1.0
To: karanthk@lycos.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: initrd failing.
References: <BJMJJOGDMKJHLAAA@mailcity.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Things to check.

Ensure that you have the correct size set in the .config. Next time,
please email the relevant .config entries for the kernel and also what
is the size of initrd.

Next, check that your boot loader is copying the initrd and kernel at
correct offset and uncompressing it. Since you mention it is a custom
board, you will have to try it on your own, these are just pointers.

Amit

karanth wrote:
> Hai,
>
> Iam Using a custom made board, using  kernel 2.2.14.  Iam able to
> boot from the NFS and from the flash, I want ramdisk to work,
> but it is failing in start_kernel.
> while booting it gives the message,
>
> Uncompressing Linux...done.
> hold_residual=00600100
> Now booting the kernel
>
> bi_memory_size = 0x04000000 ?
> Linux version 2.2.14
> Boot arguments: console=ttyS0,19200n8 root=/dev/ram0
> time_init: decrementer frequency = 247500000/60
> con_init()
> calling kmem_cache_init (memory_start=0xc019efa8, memory_end=0xc1000000)
> Initilize I2C bus: done
> Calibrating delay loop... 65.74 BogoMIPS
> initrd overwritten (0xc00721fc < 0xc019efa8) - disabling it.  ----------> why it is failing ??????????
> Memory: 14852k available (752k kernel code, 740k data, 40k init) [c0000000,c100]
> POSIX conformance testing by UNIFIX
> ......................
> .....................
>
> my question in what circumstances initrd is overwritten, how can it be avoided, and how can it be repaired.
>
> Thank for any suggestion in advance.
> Regards
> Ambarish.
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
