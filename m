Date: Wed, 16 Jun 2004 12:05:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Martin Habets <errandir_news@mph.eclipse.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Make install target work
Message-ID: <20040616190548.GD24479@smtp.west.cox.net>
References: <20040616181652.GA7240@palantir8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040616181652.GA7240@palantir8>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jun 16, 2004 at 07:16:52PM +0100, Martin Habets wrote:

> This patch makes the install target work. After all, it is already
> mentioned in the 'make help' output.
> The only question is, should it install zImage by default? I always
> install vmlinux, so I used that.

Given the number of different ways we have to deal with (this really
only handles pmac) I'd much rather just have boot/install.sh run either
the distribution or user-provided script.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
