From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B2361D@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Does 'Bitkeeper' work according to the 'kernel sources' link @ pp
	cpenguin.org
Date: Thu, 23 Jan 2003 12:03:08 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've successfully installed the cross-compiler for powerpc-linux and am
trying to build the kernel. There is a HOWTO @ ppcpenguin.org that tells you
how to cross-compile ... which is what I'm following.

This is my first time using bk. I bk'ed linuxppc_2_4, but it appears that
the whole thing does not get downloaded. For example, the "scripts/lxdialog"
directory in the kernel source tree does not have any contents other than
the SCCS directory. I find this is a consistent problem with a smattering of
diretories within the kernel source tree. I cannot successfully execute
"make menuconfig" and am stumped.

Can anyone confirm whether or not the instructions under the "kernel
sources" link at ppcpenguin.org are accurate or not?

Thanks

-- Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
