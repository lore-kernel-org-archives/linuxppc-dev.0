Date: Fri, 19 Feb 1999 23:48:01 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Scott Trimmer <strimmer@rift.foo.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Compiling Kernel 2.2.1 on a G3
In-Reply-To: <Pine.LNX.3.96.990219201949.20971B-100000@rift.foo.net>
Message-ID: <Pine.LNX.3.96L.990219234636.31229A-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 19 Feb 1999, Scott Trimmer wrote:
> 
> I have tried for weeks to get ANY kernel compiled, and I can get the
> kernel to compile.  But when I copy it into my System Folder on the mac,
> and boot every piece of text on the consoles is colored boxed with colored
> circles in the center of them.  Why is this, and what can I do?  The
> penguin in the upper right corner shows correctly, as well as the first
> message saying that kernel 2.2.1 is booting.

You need to disable "VGA font support" or something like that in the kernel
config. One would hope that 'make pmac_config' sets that value properly...

-Hollis


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
