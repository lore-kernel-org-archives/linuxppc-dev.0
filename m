Date: Wed, 30 Jun 2004 10:14:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: looking for .config file for RPXlite board for 2.6 kernel
Message-ID: <20040630171458.GA15960@smtp.west.cox.net>
References: <Pine.LNX.4.60.0406301107130.18110@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0406301107130.18110@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jun 30, 2004 at 11:12:18AM -0400, Robert P. J. Day wrote:

>
>   ok, in the interests of my mental health, i've grabbed an rpxlite
> board off the shelf, and am going to see how far i can boot it with
> the current 2.6 kernel.

'make rpxlite_defconfig' and then enable SERIAL_CPM and select SMC1 and
SCC1 (you are correct, AFAIK, about the right console being SMC1, but
this is the board I've been using and mentioning that it doesn't quite
get right).  WRT having to pass in console=, etc, iff you have
CONFIG_VT=n, which I believe is in the defconfig, you don't need to pass
anything.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
