Subject: Re: Serial Console on XServ and yaboot???
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brad Boyer <flar@pants.nu>
Cc: Bill Fink <billfink@mindspring.com>,
	LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20030312085106.GA5458@pants.nu>
References: <20030311223353.00f9a059.billfink@mindspring.com>
	 <1047455184.18956.27.camel@zion.wanadoo.fr>
	 <20030312085106.GA5458@pants.nu>
Content-Type: text/plain
Message-Id: <1047465886.18957.49.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 12 Mar 2003 11:44:46 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-03-12 at 09:51, Brad Boyer wrote:
> On Wed, Mar 12, 2003 at 08:46:25AM +0100, Benjamin Herrenschmidt wrote:
> > iirc, there is something weird with the OF params for the console
> > on the xserve. Try changing these:
> >
> > intput-device    "scca"
> > output-device    "scca"
> > input-device-1   "scca"
> > output-device-1  "scca"
>
> It may be different on the xserve, but on my 7600, the names of the
> serial ports in OF are 'ttya' and 'ttyb'.

Those are the alias names I found in an xserve device-tree dump I
keep around here. Looks like Apple changed them since the 7600...

Actually, "scca" and "sccb" are also the alias names on my tipb,
so I beleive this is a change on all newworlds or maybe all
core99's

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
