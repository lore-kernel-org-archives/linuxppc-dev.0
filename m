Date: Thu, 6 Jul 2000 07:57:13 -0700 (PDT)
From: Matt Brubeck <mbrubeck@hmc.edu>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Multi-boot advice.
In-Reply-To: <200007052323.AAA07099@hyperion.valhalla.net>
Message-ID: <Pine.GSO.4.21.0007060751390.17224-100000@turing.cs.hmc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 6 Jul 2000, Iain Sandoe wrote:

> I think I read that I must put the Linux boot partition before the
> MacOS - X one?

If you are using yaboot with an OF-bootable partition (e.g. you are using
ybin to set up a bootstrap partition), then placing that partition before
MacOS will allow you to boot Linux by default without changing any open
firmware settings.

Other than that, partition order shouldn't matter.

Speaking of yaboot, I have a question. Can yaboot boot MacOS, or can I
make it exit back to OF without rebooting?

I'd like to just have my machine always load yaboot, and then use the
yaboot prompt to choose my OS. But once I'm in yaboot, Linux seems to be
my only option. Is this true? If so, can it be changed?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
