Message-Id: <m0znhJZ-0000WVC@tri-yann.crf.canon.fr>
Date: Wed, 9 Dec 1998 11:57:53 +0100 (CET)
From: "VALETTE Eric" <valette@crf.canon.fr>
To: cort@persephone.cs.nmt.edu
CC: mmporter@home.com, alois_fertl@muenchen.europe.mcd.mot.com,
        linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.LNX.3.96.981209020440.14818A-100000@persephone.cs.nmt.edu>
	(message from Cort Dougan on Wed, 9 Dec 1998 02:05:52 -0700 (MST))
Subject: Re: Linux-2.1.129 boot on MCP750
References: <Pine.LNX.3.96.981209020440.14818A-100000@persephone.cs.nmt.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Cort" == Cort Dougan <cort@persephone.cs.nmt.edu> writes:

Cort> You can change the address that ppcbug loads the image to.  I pointed mine
Cort> at the end of memory to keep it out of the way.  The boot code for prep is
Cort> very delicate right now due to the many many addresses that boards load
Cort> the image at so anything that can make it easier (such as moving the
Cort> address the kernel is loaded at) I want to take advantage of.

I would like to have the instruction to make that.

Have a nice day,

-- eric

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
