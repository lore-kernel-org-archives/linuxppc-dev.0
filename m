Message-ID: <3ADB7589.EE24D53B@mvista.com>
Date: Mon, 16 Apr 2001 18:43:21 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Laura Dean <tralad@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Mounting NFS on RPX-Lite
References: <20010416185955.41462.qmail@web12402.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Laura Dean wrote:

> I expect this on the kernel I built from source, but I
> was expecting the Hard Hat kernel to be mounting
> /opt/hardhat/devkit/ppc/8xx/target. I assumed the
> "option root-path" line in dhcpd.conf configured this.

Version 2.0 DHCP doesn't work properly with some BOOTP
clients, in particular when providing this "extended"
type of information.  I suspect this may be the
problem, and suggest you check out isc.org for information.

I personally run Beta 3.0.

It still looks like you may have some NFS related
configuration problems on the server, too.

Oh yeah, NFS root works fine, whether you recompile or
use the ready made kernels.

	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
