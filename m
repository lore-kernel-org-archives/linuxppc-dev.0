Date: Thu, 3 Jun 1999 15:58:31 +1000
Message-Id: <199906030558.PAA00552@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: brad@turbolinux.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.LNX.3.95.990602005536.28345A-100000@pacific.pht.com>
	(message from Brad Midgley on Wed, 2 Jun 1999 01:07:06 -0600 (MDT))
Subject: Re: rsync kernel compile fails
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.3.95.990602005536.28345A-100000@pacific.pht.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad Midgley <brad@turbolinux.com> wrote:

> is the rsync kernel supposed to be working? i haven't changed my config
> but it fails to compile:

Well, the first problem is that drivers/Makefile goes into the usb
subdirectory for CONFIG_USB rather than the uusbd subdirectory.  Also
that tree doesn't have the multi-keyboard patch (and it won't apply
easily).

I have a 2.3.4 kernel working but without USB.  I plan to work on
getting the new USB stuff working on the iMac soon.  But in the
meantime maybe I need to get a recent 2.2.x kernel working with the
old UUSBD stack.  What I might do actually is kludge the USB keyboard
driver to convert all the keycodes to ADB keycodes, instead of
continuing with the multi-keyboard patch.

I have updated the rsync repository so that the linux-pmac-stable
module has the 2.2.7 tree that used to be in the linux-pmac-devel
module, and the linux-pmac-devel module now has a 2.3.4 tree.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
