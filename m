Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Sat, 2 Nov 2002 04:11:13 +1100
From: Anton Blanchard <anton@samba.org>
To: Daniel Lao <laodx@gzjpg.com>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: About the process's logical space :-(
Message-ID: <20021101171113.GB2746@krispykreme>
References: <200211011030515.SM00332@xuyf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200211011030515.SM00332@xuyf>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I have used the linuxppc development env. with 2.2.12 kernel, the
> process can only map to the logical address between 0x0 - 0x80000000.
> But under the redhat (kernel 2.2.5, x86), I can map to 0x0 -
> 0xC0000000!!!  Is the 2.4.x ppc kernel also have the limit?

You can change this on newer kernels (its a config option,
CONFIG_TASK_SIZE). Eg on my titanium powerbook running 2.4.20-pre4:

# cat /proc/self/maps
...
bfffe000-c0000000 rwxp fffff000 00:00 0

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
