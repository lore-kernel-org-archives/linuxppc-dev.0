Subject: Re: /proc/sys/kernel/l2cr and the 750FX
From: "Guy M. Streeter" <streeter@redhat.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20030925182151.GB7337@ip68-0-152-218.tc.ph.cox.net>
References: <1064506838.1037.11.camel@jarjar.hsv.redhat.com>
	 <20030925182151.GB7337@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain
Message-Id: <1064518676.1037.13.camel@jarjar.hsv.redhat.com>
Mime-Version: 1.0
Date: 25 Sep 2003 14:37:56 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I don't see any difference in this section of code, in v2.4.23-pre5
Was a change made someplace else to support the 750FX?

--Guy

On Thu, 2003-09-25 at 13:21, Tom Rini wrote:
> On Thu, Sep 25, 2003 at 11:20:39AM -0500, Guy M. Streeter wrote:
>
> > The 750FX has a different L2CR register layout than other processors.
> > The attached patch against 2.4.22 makes /proc/sys/kernel/l2cr show a
> > better decode of the register for the 750FX.
>
> This shouldn't be needed in 2.4.23-current, can you verify?  Also,
> adding more PVR_XXXX defines is deprecated, as there are cpufeatures for
> such things.
>
> --
> Tom Rini
> http://gate.crashing.org/~trini/
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
