Date: Tue, 4 Sep 2001 13:07:33 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: John Tyner <jtyner@cs.ucr.edu>,
	linuxppc-commit@source.mvista.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc405 enet changes (fwd)
Message-ID: <20010904130733.A14548@ecam.san.rr.com>
References: <Pine.LNX.4.30.0109031513110.21186-200000@hill.cs.ucr.edu> <20010903202915.A25163@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010903202915.A25163@cpe-24-221-152-185.az.sprintbbd.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Sep 03, 2001 at 08:29:15PM -0700, Tom Rini wrote:
> On Mon, Sep 03, 2001 at 03:14:03PM -0700, John Tyner wrote:
>
> > Is this patch going to be applied to the kernel? I haven't seen it in the
> > logs...
>
> iirc, there were some questions/comments about the driver which weren't
> answered.  Also, this adds some LINUX_VERSION(x,y,z) bits which are also
> bad since 405 doesn't quite work yet for everyone.  So if nothing else,
> these should be removed from the patch.

I think the main question on the reason to remove the statics was answered.
That is really the main change in the code, there are some tweaks to the
interupt handlers but not much. The other questions are more on future
changes to the driver.

The reason for the Linux Vers macros was to at least let us(and others) test the
changes on the last working kernel from mvista. You should be able to pull
them if you want to merge the code in, but I thought it would be best to
leave them in so the other code changes could be tested.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
