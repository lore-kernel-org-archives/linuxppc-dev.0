Date: Fri, 14 Nov 2003 09:27:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Guy M. Streeter" <streeter@redhat.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: /proc/sys/kernel/l2cr and the 750FX
Message-ID: <20031114162745.GE13003@ip68-0-152-218.tc.ph.cox.net>
References: <1068824641.18764.7.camel@jarjar.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1068824641.18764.7.camel@jarjar.hsv.redhat.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Nov 14, 2003 at 09:44:01AM -0600, Guy M. Streeter wrote:

>   In September I posted a version of this patch, which corrects the
> formatted display of the L2CR register for 750FX processors.
> Tom Rini suggested that it should use a cpu feature flag instead of the
> processors version register, and also that the change might already have
> been made in later kernel source.
>   I have check all the 2.4.23+ and 2.6.0 source trees, and I don't see
> any fix for this. I have changed the patch to use a feature flag instead
> of checking the PVR. I would like to see this change considered for
> inclusion.

I've checked this into my 2.4.24-pre tree.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
