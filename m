From: "Kwansuk Kim" <kskim@neowave.co.kr>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Using gdbserver...
Date: Thu, 28 Dec 2000 11:46:36 +0900
Message-ID: <NEBBKFENMLEDKDHMEHPJIECCCCAA.kskim@neowave.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, everyone!

I'm using my MPC860 custon board, kernel 2.2.13, and cross-gdb 4.1.8

I copied the gdbserver in Monta Vista CDK on the NFS bin directory, and did cross-debug with the gdb in the CDK.

I used ethernet on SCC1, and it worked very well except Ctrl-C interrupt.

It didn't worked.

I searched the GDB manual, and I found this...

'if you type the interrupt character (often <C-C>), GDB attempts to stop the program. This may or may not succeed, depending in part on the hardware and the serial drivers the remote system uses.'

Is it impossible to interrupt?

I'm looking forward to your answer...

Happy New Year!

Kwansuk Kim.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
