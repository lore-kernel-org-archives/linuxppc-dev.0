Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3DF510E2.1060102@redswitch.com>
Date: Mon, 09 Dec 2002 13:53:38 -0800
From: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Which kernel tree should I keep up with?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Embedded Linux PPC Gurus,

Someone else might have asked such a question before and there seemed to
be no answer so far. Recently I am in the similar situation where I want
to upgrade my linux system.

I'm using Linux distribution from DENX (basically 2.4.4). It's stable
and has lots of features that official kernel tree dosn't have until
recently I encountered a maybe weird probelm on mtd devices (its mtd
code is not uptodate). This forced me to upgrade mtd code first.
Unfornately the lates mtd code is no longer compatible with linux
kernels whose version are less than 2.4.11. :( I guess there should be
some effort to make mtd code backward compatible. So I'm thinking to
upgrade the kernel to the latest one. Problem is that there seemed to be
several choices which I don't know how to choose.

One choice is of course the official release from www.kernel.org.
Another is from bkbits.net or mvista.com. Which one is better for
embedded linux PPC system? When www.kernel.org release a new version, do
bkbits.net and mvista.com encompass it in their trees? Thanks for your
advices.

- Shawn.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
