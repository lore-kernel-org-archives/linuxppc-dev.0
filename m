Date: Wed, 10 Feb 1999 14:53:05 +1100
Message-Id: <199902100353.OAA05305@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: bh40@calva.net
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <19990209204546.006029@mail.mipsys.com> (message from BenH on
	Tue, 9 Feb 1999 20:45:46 +0100)
Subject: Re: Xpmac compatibility
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <19990209204546.006029@mail.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


BenH <bh40@calva.net> wrote:

> Is the code that sends mouse buttons & movements as keycodes needed only
> for Xpmac compatibility ? Or is it something standard ? I was thinking

Only for Xpmac compatibility AFAIR.

> about conditionally defining it, probably using the CONFIG_FB_COMPAT_XPMAC.

Sounds reasonable.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
