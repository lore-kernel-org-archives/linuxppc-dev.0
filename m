Return-Path: <eswierk@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id 1E980DDF59
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Mar 2007 14:11:56 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so1628130nfc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 20:11:55 -0700 (PDT)
Message-ID: <c1bf1cf0703222011j5bdf3caajcd38e0c686bd921c@mail.gmail.com>
Date: Thu, 22 Mar 2007 20:11:55 -0700
From: "Ed Swierk" <eswierk@arastra.com>
Sender: eswierk@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: kexec for powerpc arch 834x board?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm trying to get kexec to boot a powerpc arch kernel on a Freescale
834x board, but kexec-tools-1.101 seems to support only the Gamecube
on 32-bit ppc.

I tried hacking a memory range of 0x00030000 - 0x08000000 into kexec,
and feeding it the vmlinux  ELF image that's generated when I build
the kernel, but kexec complains about 0xc0000000 being an invalid
memory range.

As far as I understand, 0xc0000000 is the kernel start address in
virtual memory, and it's not clear how to get kexec to load the
vmlinux image at a reasonable physical address (like 0x00030000).

Do I need to build a different powerpc image to make kexec happy, or
is some hacking needed in the kexec userland program? Am I missing a
more powerpc-capable version of kexec-tools?

--Ed
