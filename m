Date: Wed, 12 Mar 2003 00:51:06 -0800
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bill Fink <billfink@mindspring.com>,
	LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Serial Console on XServe and yaboot???
Message-ID: <20030312085106.GA5458@pants.nu>
References: <20030311223353.00f9a059.billfink@mindspring.com> <1047455184.18956.27.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1047455184.18956.27.camel@zion.wanadoo.fr>
From: flar@pants.nu (Brad Boyer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 12, 2003 at 08:46:25AM +0100, Benjamin Herrenschmidt wrote:
> iirc, there is something weird with the OF params for the console
> on the xserve. Try changing these:
>
> intput-device    "scca"
> output-device    "scca"
> input-device-1   "scca"
> output-device-1  "scca"

It may be different on the xserve, but on my 7600, the names of the
serial ports in OF are 'ttya' and 'ttyb'.

	Brad Boyer
	flar@allandria.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
