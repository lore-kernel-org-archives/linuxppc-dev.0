Date: Fri, 2 Jul 2004 08:37:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Netconsole on 8260
Message-ID: <20040702153717.GE15960@smtp.west.cox.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B06DB1C@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DB1C@ismail.innsys.innovsys.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jul 01, 2004 at 05:17:01PM -0500, Rune Torgersen wrote:

> Hi
> I am trying to get netconsole up and running on a 8260 kernel (2.6.7)
>
> My problem is that the netconsile driver seems to start (and abort) way
> too eraly for the 8260. The FCC ethernet drivcer is not initialized yet,
> so the netconsiole driver aborts because it cannot find the ethernet
> device.
>
> Anybody know how to delay the startup of the netconsole driver to after
> FCC ethernets are up?

AFAIK, the cpm2 enet drivers do not support the NETPOLL API, so
netconsole will not work yet.  But the early initalization of netconsole
is fine, that's just setting up the params.  Once ethernet comes up, the
console gets dumped out.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
