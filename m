Date: Thu, 05 Dec 2002 13:28:31 -0500
From: Stefano Bodini <s.bodini@comcast.net>
Subject: RE: Frozen ! any idea ?
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <5.1.0.14.0.20021205132823.00a3aac0@pop3.norton.antivirus>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all ... just my little testimonial about the problem.
Well, Linux and the little board were always working.
The freeze actually was minicom on the host, used to "speak" to the console !!!
I don't know why minicom freeze after 1 minute but sure I will not use it
anymore !

So Linux is working well on the board.

Now I have to solve the problem to have the kernel running if compiled with
the gdbserver option enabled.

In order to try to debug something I enabled the KDGB in the kernel
(following the instructions on the MontaVista documentation).

I recompiled the kernel, no errors .. but when I try to load and start it :

[Go 00400000]
loaded at: 00410000 004A81F4
relocated to: 00400000 004981F4
board data at: 00495128 00495144
relocated to: 004052C4 004052E0
zimage at: 00405960 004945AA
avail ram: 00499000 01000000

Linux/PPC load: root=/dev/nfs rw ip=auto
Uncompressing Linux...done.
Now booting the kernel

That's it.
Stops. No warning, no errors .. just stops.
I'm sure this is not a minicom problem this time ... any ideas ?

Many many thanks in advance

C'ya
	Steve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
