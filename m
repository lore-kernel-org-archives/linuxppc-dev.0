Date: Wed, 16 Dec 1998 10:04:12 +1100
Message-Id: <199812152304.KAA14476@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: bh40@calva.net
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <19981215143756.003692@mail.mipsys.com> (message from Benjamin
	Herrenschmidt on Tue, 15 Dec 1998 14:37:56 +0100)
Subject: Re: BootX, ramdisk and root device
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <19981215143756.003692@mail.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <bh40@calva.net> wrote:

> I was wondering: Is there any case where a user may want to have both
> "Use RamDisk" and a specified root device ? Should I ignore the content

Not normally.

> of the root device field when ram disk is used ? (It still possible to

Yes, I think so.

> Similar issue: should I lookup and remove any "video=xxxx" option from
> the kenrnel args prior to booting the kernel when "no video driver" is
> checked or is this harmless ?

This one is harmless, since the video=ofonly option will override
other video=xxx options.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
