Date: Mon, 24 Mar 2003 13:11:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Leigh Brown <leigh@solinno.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC][PATCH] Put PReP boot arguments in a fixed location in the boot image
Message-ID: <20030324201134.GA14264@ip68-0-152-218.tc.ph.cox.net>
References: <61347.213.107.143.228.1048365078.squirrel@www.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <61347.213.107.143.228.1048365078.squirrel@www.solinno.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Mar 22, 2003 at 08:31:18PM -0000, Leigh Brown wrote:

> I have been using this patch very successfully for ages.  Having the
> boot arguments in a fixed location in the boot image makes it trivial
> to write a program to set the arguments.
>
> Please take a look at the patch and let me know what you think.  If
> there are no negative comments I shall post it again for inclusion.
> The patch should apply against linuxppc_2_4 and linuxppc_2_4-devel.

The changes to 'mkprep' I _think_ would break non-'PReP' systems using
that.  Please modify simple/head.S (and related) in a similar fashion,
and present this is a patch against 'linux-2.4' (GNU or BK patch is
fine with me).  Thanks.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
