Date: Thu, 20 Jul 2000 09:00:48 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Sacha Varma <sacha@ssl.co.uk>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI compatibility
In-Reply-To: <39771F7D.EC15EC8D@biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10007200858200.22862-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 20 Jul 2000, Michael Schmitz wrote:

> > Correct, there is nothing preventing any PCI graphics device from working
> > in linux unless there is something extremely fundamentally wrong with it
> > (like relying on PC BIOS too much, but that is very rare)
>
> Or Linux not finding the card because it didn't get an OF device tree
> node?

No, all devices get OF device tree nodes, just not 'real' ones if they
don't have an OF rom.  Also, relying on OF device tree nodes in video
display drivers is not smart because I've noticed in the past that some of
the address in the node are off a bit.  It is always wiser to use the PCI
nodes instead of 'fake' (or even real) OF nodes.


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
