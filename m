Date: Sun, 26 Nov 2000 13:40:20 -0800
From: Logan Johnson <logan@slackware.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: USB Keyboard and 2.2.18pre
Message-ID: <20001126134020.A15022@slackware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all!  I've run into an interesting problem with the newer stable kernels.
I have an iMac DV SE (400MHz, the first DV SE.. with the stubby keyboard).
2.2.18pre21 and pre22 and pmac_stable all seem to have the same problem, which
is that the keyboard is non-functional at the console.

The keyboard is detected and is bound to input0.  I can ssh in,
'cat /dev/input/event0', and watch my terminal fill with garbage as I mash
keys on the keyboard.  But I can't get any characters to show up on the
console.

The USB mouse also works fine, as I can gpm all over my boot messages.  (I
tried copying and pasting a root login for fun, but realized after the 't'
that it was really hard to copy and paste a carriage return. ;)

It doesn't seem to be a keymap issue, as both mac-us-std and us fail to
produce any characters onscreen from any keys.

The 2.2.15 that shipped with linuxppc 2000 seems to have a perfectly functional
keyboard, so my suspicion is that the problem lies in the new input layer I've
read so much (and yet so little) about.

Has anyone else seen this issue?  Alternatively, can anyone else with my
hardware duplicate (or fail to duplicate) the problem?  I can post my kernel
config(s) if needed.

Also, I'm perfectly happy to serve as a guinea pig if someone has an idea on
this but not the hardware to test it with.


	--Logan

--
	Logan Johnson | logan@slackware.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
