Message-ID: <383AFEF9.1EFCB317@mitre.org>
Date: Tue, 23 Nov 1999 15:54:54 -0500
From: Frank McPherson <frank@mitre.org>
MIME-Version: 1.0
To: Jim Chapman <jim.chapman@iname.com>
CC: LiuTao <tliu@ict.ac.cn>,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: need suggestions
References: <383AF067.2B8EB961@iname.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jim and others, 

We did some work last summer with a Dy4-177 VMEbus board which came to
us with the VxWorks bootrom intact, and used a similar solution to
yours.  

> The
> binary-to-assembly convertor is a simple perl script which does almost
> the same thing as vxWorks' binToAsm tool.

We are using a piggyback.c (different from the one in chrpboot)  to
produce the assembly.   It's probably no better or worse than the perl
script you've got.  

> The initrd stuff would need similar treatment, but since I don't use
> initrd, I haven't implemented it.

We DID find it useful to have initrd support, so our Makefiles can use
piggyback to make a tftp/vxworks loadable Linux kernel.   If this is
something you could use, please let me know.  

Cheers, 

Frank

-- 
Frank H. McPherson IV
W118 Embedded Solutions Team
The MITRE Corporation
703-883-5404

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
