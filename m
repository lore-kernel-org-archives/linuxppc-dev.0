Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B2367D@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: linuxppc_2_4_devel from denx vs. bitkeeper
Date: Fri, 21 Feb 2003 08:02:52 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I understand that ppc.bkbits.net is the root repository for the
linuxppc_2_4_devel tree. I am also using DENX ELDK for a 440GP embedded
project ... the linux host development box being and x86 based RH8.0
machine.

Question: What is the difference between using the kernel source found at
the denx website, versus cloning/rsynching directly from the root
respository. I know the denx Makefile is different from the root repo
Makefile ... in a good way as it allows my ppc_4xx kernel to compile.

Going forward, I want to have (a) a kernel that compiles and (b) a
relatively easy way to rsynch any desired updates into my kernel in a
relatively painless manner.

My current throught is to use bkbits and modify the Makefile according to
DENX in my local custom kernel branch. I can then rsync according to bkbits
updates as opposed to using the DENX source ... which seems to use a
combination of CVS and BK.

Are there other differences (i.e. adding functionality) provided by DENX
that would make me want to use the DENX source instead? That's my basic
question.

Thanks again,

-- Brian

p.s. I've been trying to understand what potential differences there are
between the 2 kernel trees by diffing specific releases ... but with the
DENX source being CVS controlled and the root repo being bk controlled, I'm
having a tough time, even after sucking out the CVS and SCCS dirs.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
