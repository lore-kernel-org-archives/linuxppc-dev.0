Message-ID: <40E28706.4050508@dev.rtsoft.ru>
Date: Wed, 30 Jun 2004 13:25:26 +0400
From: Yuri Frolov <yfrolov@dev.rtsoft.ru>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kgdb on Motorola 8451 ppc board
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 > I'm trying to run kgdb on  Motorola 8451 ppc board.
 > I've compiled the kernel with the CONFIG_KGDB option.
 > The test machine is a linux host.

Which platform does your linux host runs on?

 > Ignoring packet error, continuing...
 > Ignoring packet error, continuing...

What sort of gdb are you using on your linux host? Is it a version which
compiled for correct target (ppc with correct endian in your case, see
Net for further explanation)? If you're using vanilla gdb from your's
x86 distribution package (which compiled with source = target = x86),
then you should move to correctly prepared gdb...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
