Date: Mon, 13 Dec 1999 10:28:05 +0100
To: linuxppc-dev@lists.linuxppc.org
CC: paulus@linuxcare.com
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Weird IDE block devices problem
Message-Id: <19991213102805.001474@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

Samuel Rydth (the author of Mac-On-Linux) sent me the following message.
This sound weird since it looks like order is not enforced by the IDE
block driver. Is this normal or is this a kernel bug ? I beleive it
happened with  2.2.10-2.2.13 kernels (I have to confirm this).

On Sun, Dec 12, 1999, Samuel Rydh <samuel@ibrium.se> wrote:

---------------- Begin Forwarded Message ----------------
Btw. I found an oddity with the IDE block device interface
(causes problems with DropStuffit in MacOS 9). In a sequence like

	write	A to sector N
	write	B to sector N
	read	     sector N

then the read might not return the information "B" (but something
else). I've always assumed that the block device drivers were 
supposed to enforce this consistency but I might be wrong. Everything 
work as it should if an extra "fsync" is inserted after each
write. This might impact driver performance though.


----------------- End Forwarded Message -----------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
