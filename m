Date: Thu, 4 Feb 1999 17:11:24 +1100
Message-Id: <199902040611.RAA04100@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: brad@pht.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.LNX.3.95.990203225338.8064A-100000@pacific.pht.com>
	(message from Brad Midgley on Wed, 3 Feb 1999 22:56:21 -0700 (MST))
Subject: Re: rsync kernel is incomplete
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.3.95.990203225338.8064A-100000@pacific.pht.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad Midgley <brad@pht.com> wrote:

> could you open drivers/uusbd?
> 
> rsync -avz samba.anu.edu.au::linux-pmac-devel /mnt/nfs/linux
>  [...]
> receiving file list ... opendir(drivers/uusbd): Permission denied

Oops, sorry, fixed now.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
