Message-ID: <006a01c1bf2e$7133de30$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: "Derrik Weeks" <derrikW@iotech.com>,
	"linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <E0A487F3EEFFD111A3C5004033933F9ABBF6C3@postoffice.iotech.com>
Subject: Re: execve system call question
Date: Wed, 27 Feb 2002 10:31:11 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Derrik Weeks!

> IMMR needs to be located in high memory above F0000000.

The MPC755 doesn't have an IMMR.
If it is because all the I/O should be locaced above F0000000, please let me know. The serial port of my board is located at 0x78000000.

> kernel will crash whether you're running NFS or a ram disk.

You are right I tried ramdisk but kernel crashed.

Thank you for the reply.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
