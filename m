Date: Thu, 25 Sep 2003 11:21:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Guy M. Streeter" <streeter@redhat.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: /proc/sys/kernel/l2cr and the 750FX
Message-ID: <20030925182151.GB7337@ip68-0-152-218.tc.ph.cox.net>
References: <1064506838.1037.11.camel@jarjar.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1064506838.1037.11.camel@jarjar.hsv.redhat.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 25, 2003 at 11:20:39AM -0500, Guy M. Streeter wrote:

> The 750FX has a different L2CR register layout than other processors.
> The attached patch against 2.4.22 makes /proc/sys/kernel/l2cr show a
> better decode of the register for the 750FX.

This shouldn't be needed in 2.4.23-current, can you verify?  Also,
adding more PVR_XXXX defines is deprecated, as there are cpufeatures for
such things.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
