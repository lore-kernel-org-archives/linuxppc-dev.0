Message-ID: <3817B62A.71757E99@wanadoo.fr>
Date: Thu, 28 Oct 1999 04:34:18 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Ani Joshi <ajoshi@shell.unixbox.com>,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: bypassing MacOS using Open Firmware on Apple pmac G3 
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 22 Oct 1999, Ani Joshi wrote:

[...]
>         2.4?  if its 2.3 you mean, hfs works fine with the latest (2.3.22
> on my box is doing hfs fine), 
[...]

Amid all the shouting, no one seems to have picked up on this.

Are you serious about hfs running correctly in 2.3.22? If yes, this
would be a major breakthrough. What is your patch (certainly more than
just commenting out the undefined "update_vm_cache")?

If I cp anything to an hfs partition under 2.3.xx (xx >= 18), I get an
immediate system freeze without error message, and I have to force
reboot. Mounting hfs partitions read-only seems to work, though.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
