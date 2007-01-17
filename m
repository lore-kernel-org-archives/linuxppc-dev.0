Return-Path: <dwilson@dslextreme.com>
Received: from mail5.dslextreme.com (mail5.dslextreme.com [66.51.199.81])
	by ozlabs.org (Postfix) with SMTP id A735FDDE08
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Jan 2007 09:57:45 +1100 (EST)
Message-ID: <2a3fca25c4aa9e1d2a85c9ea.20070117145746.qjvyfba@www.dslextreme.com>
Date: Wed, 17 Jan 2007 14:57:46 -0800 (PST)
Subject: Re: ram-disk root file system
From: dwilson@dslextreme.com
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David H. Lynch Jr. wrote:

> Dan Wilson wrote:
>> We are attempting to use an initrd ram-disk as the permanent root file
system for a MPC8541-based system.
>>
>> We are using ELDK 4 to cross-compile, and are running linux 2.6.15
kernel, with u-boot 1.1.6 as our bootloader.
>>

>    I had similar problems with a permanent initramfs filesystem. It is
>possible your problem has nothing to do with your filesystem.
>

Can you tell me what your problem was, and how you resolved it?
I spent some time today reading about initramfs file systems, and have
built one of those
and tried it, with the same result, although linux did report that it saw
an initramfs instead
of an initrd.

>    First, I presume the debugging you added was in init/main.c.
>          Before you attempt to exec init, you can add code to open
>anyfile that you want on the ramdisk. opening a file requires less
>things to be right than exec'ing and that may isolate your problem
>further. I beleive you can enable system call tracing and find out more
>about where things are going off the rails.
>          You can also write a trivial hello world - one that does not
>use any libraries and very little code, and see if you can exec that.
>
>    When you boot Linux NFS - are you using the same linux kernel ?

Yes, I am using the same kernel.

Thanks for your help,

Dan.
