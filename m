Date: 25 Sep 2002 14:23:11 -0000
Message-ID: <20020925142311.18806.qmail@mailFA12.rediffmail.com>
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: higher uart baud rate corrupts image..
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


A quick question..

i have been to use succesfully bootloader kernel and ramdisk , but
only on certain serial port speed .

I am facing a data corruption in dowloading kernel+ramdisk image
at higher serial port speed.

if i set my baud speed to 19200 it WORKS FINE.

otherwise at higher serial port speed  the execve of /bin/sh just
hangs and .

also this problem is related to cpu frequency when i make that
lower or higher the behaviour changed unpredicatabley.

somebody pointed for skew problem woth sdram at higher cpu
frequency.

any body has more here to add...

__________________________________________________________


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
