In-Reply-To: <v04103d00b2f3c9868068@[208.150.38.73]>
Date: Sat, 20 Feb 1999 14:31:44 +0100
To: Steven Bytnar <s-bytnar@uiuc.edu>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: PPC Privileged mode
Message-Id: <19990220143144.012590@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 19, 1999, Steven Bytnar <s-bytnar@uiuc.edu> wrote:


>How do I exit cleanly from PPC supervisor mode to MacOS? I am trying 
>to work with the code in BootX, but it was meant to execute the 
>kernel and never return. My purpose is only to read and write to 
>supervisor read/writable registers on the chip without destroying 
>MacOS.

Use the code in "GrabG3CacheSettings". It uses a different mecanism by
patching MacOS "sc" exception handler.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
