From: "barry.fisher" <barry.fisher@seranoa.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: User to kernel buffer size limitations
Date: Mon, 11 Feb 2002 17:19:29 -0500
Message-ID: <000001c1b34a$2c8dd910$7d0110ac@Seranoa.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello All:
Are there any buffer size limitations when transferring data from user
space to the kernel. I have a application that is attempting to load an
fpga by reading from a file (I am not sure how big this file will get)
and sending (via a write) it down to a device driver which then feeds it
to the fpga. I would like to maximize the thruput and any
suggestions/comments would be greatly appreciated. Thanks in advance for
any help!
Regards,
Barry O. Fisher
Seranoa Networks
barry.fisher@seranoa.com
978-897-3434 x272


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
