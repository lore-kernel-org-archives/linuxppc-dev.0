Message-ID: <CA78D1B723D8D411AF0300508BDCF74F871337@NTCORREO>
From: GOTZON ASTONDOA <gastondoa@fagorautomation.es>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Debugging with gdb problem
Date: Mon, 21 Jan 2002 10:39:38 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everibody:

	I want to start debugging our applications with gdb and gdbserver,
but it does not work.
	The gdbserver says:
		chroot /nfs gdbserver 10.0.17.20:2345 sample
		Process sample created; pid = 28
		getprotobyname: No such file or directory.
		Exiting
	And the gdb says:
		chroot /nfs gdbserver 10.0.17.20:2345 sample
		Process sample created; pid = 28
		getprotobyname: No such file or directory.
		Exiting

	I am using busibox. It would be a problem of the busibox shell?How
can y solve the problem?

	Thanks for your help.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
