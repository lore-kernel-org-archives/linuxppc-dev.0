Message-ID: <37C6CA26.49441879@wanadoo.fr>
Date: Fri, 27 Aug 1999 19:25:58 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl@munich.netsurf.de>
CC: linuxppc-dev@lists.linuxppc.org, Paul.Mackerras@cs.anu.edu.au
Subject: Re: vger-2.3.15 on pmac
References: <4.2.0.58.19990826171730.00981650@mail.lauterbach.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:

> What's still NOT fixed in 2.3.15 and really annoying for a lot of users is
> "FB. overflow" aka "macserial: flipbuffer overflow". This was introduced
> somewhere late 2.1 or early 2.2. I think this one is responsible for some
> of the hard crashes reported on linuxppc-users under the "Communicator
> crashes X" thread.

I don't know if it is related, but I had several other hard freezes in
the
meantime. One reproducible method is to run xdir (or gftp, works too),
connect to a remote site, wait until the connection is established,
choose "quit" from the menu, confirm, and boom! hard freeze. If I don't
connect to a remote site, there is no freeze. I don't know how to debug
this, because I don't see any error messages.

The other kernel panics arrived at the end of the boot process or during
login. The message was "kernel stack overflow, in swapper task, not
syncing", many lines of "page fault in interrupt handler, addr=c". The
kernel addresses given were all init_task_union + offset.

Another strange thing, or maybe it is related, are error messages in my
/var/log/dhcpd.log file:

Aug 27 12:04:42 rennes-28 dhcpcd[185]: corrupted UDP msg with
uh_ulen=312 in_cksum=-2 discarded 
Aug 27 12:05:37 rennes-28 last message repeated 16 times
Aug 27 12:06:28 rennes-28 last message repeated 3 times

Such messages appear irregularly, about every 10 minutes. There is no
clear relation with the dialog with my dhcp server. Otherwise the net
traffic over ethrnet/adsl/dhcp seems to work correctly.
 
This happens only with 2.3.15, not with 2.2.12. In the log file I find
that I had such messages also between June 3 and June 13. I think these
were the times when I tried 2.3.x kernels.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
