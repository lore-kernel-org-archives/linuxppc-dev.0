From: ramp@oddjob.uchicago.edu
Date: Sun, 13 Feb 2000 01:42:52 -0600 (CST)
To: Nelson Abramson <pogtal@erols.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Sucess with 2.3.44pre !!
In-Reply-To: <38A64DF1.FDEF5815@erols.com>
Message-ID: <Pine.LNX.4.10.10002130137570.5208-100000@xpol.uchicago.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



OK _ Lots more progress. Kernel 2.3.44pre compiles and boots. Turns out
that I should *not* select HIDBP for mouse/keyboard in the dot config.
Keyboard and mouse do register as well as the USBZip drive. Now I have to
figure out how to mount and read/write from it.

Ramprasad


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
