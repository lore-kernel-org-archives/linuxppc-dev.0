From: "Steve Boorman" <steveb@baydel.com>
To: linuxppc-embedded@lists.linuxppc.org
Date: Mon, 14 Jul 2003 17:31:44 +0100
MIME-Version: 1.0
Subject: Hangup booting Linux on PPC440GP 
Reply-To: Steve Boorman <steveb@baydel.com>
Message-ID: <3F12E900.23193.19E927F@localhost>
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have an IBM PPC440GP evaluation board (Ebony) which I am
trying to get Linux up and running on.

I read the Cross development mini-howto and downloaded the relevant
files to an X86 based machine, these were binutils-2.14.90.0.4.1,
gcc-core-3.3 and linux-bk-2.4-devel-2.4.21-pre4. Following the mini-howto
I successfully built the kernel. This kernel is loaded using the IBM
Openbios over the ethernet from a Motorola Starmax (603e based I think)
and mounts the root filesystem over nfs which resides on the Starmax.
Everything looks good until Linux attempts to run /sbin/init, then the
machine hangs up, no panic or anything else displayed on the console. If I
remove /sbin/init then I do get the obvious panic, "No init found.  Try
passing init= option to kernel."

I tried replacing /sbin/init with a static linked program which just does a
printf of "hello world", this hangs in the same way with no message. This
prog was compiled using the Starmax running Yellow Dog V3, kernel
2.4.20-8D / gcc 3.2.2.

Any ideas as to what is wrong would be most appreciated.

Regards,
Steve Boorman


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
