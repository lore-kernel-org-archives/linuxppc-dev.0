Date: Thu, 17 Jun 2004 12:38:22 +0100
From: Martin Habets <errandir_news@mph.eclipse.co.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Make install target work
Message-ID: <20040617113822.GB9175@palantir8>
References: <20040616181652.GA7240@palantir8> <20040616190548.GD24479@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040616190548.GD24479@smtp.west.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jun 16, 2004 at 12:05:48PM -0700, Tom Rini wrote:
>
> On Wed, Jun 16, 2004 at 07:16:52PM +0100, Martin Habets wrote:
>
> > This patch makes the install target work. After all, it is already
> > mentioned in the 'make help' output.
> > The only question is, should it install zImage by default? I always
> > install vmlinux, so I used that.
>
> Given the number of different ways we have to deal with (this really
> only handles pmac) I'd much rather just have boot/install.sh run either
> the distribution or user-provided script.

Ehh.. that's exactly what install.sh tries to do! Only if both of these
do not exist will the bottom part of the code be executed.
The distribution provided scripts want an image to install. I agree
that it is impossible to supply the right image for all systems.
But maybe it is possible to echance this patch for some systems,
providing a different image based on config settings?

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
