Message-ID: <39771F7D.EC15EC8D@biophys.uni-duesseldorf.de>
Date: Thu, 20 Jul 2000 17:49:17 +0200
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Reply-To: schmitz@opal.biophys.uni-duesseldorf.de
MIME-Version: 1.0
To: Ani Joshi <ajoshi@shell.unixbox.com>
CC: Sacha Varma <sacha@ssl.co.uk>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI compatibility
References: <Pine.LNX.4.10.10007200804160.22316-100000@shell.unixbox.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ani Joshi wrote:
>
> On Thu, 20 Jul 2000, Sacha Varma wrote:
>
> > So... does this mean that as far as hardware is concerned there is nothing to prevent me from using any old PCI graphics card in a (non-AGP?) mac so long as linux has drivers for it?
>
> Correct, there is nothing preventing any PCI graphics device from working
> in linux unless there is something extremely fundamentally wrong with it
> (like relying on PC BIOS too much, but that is very rare)

Or Linux not finding the card because it didn't get an OF device tree
node?

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
