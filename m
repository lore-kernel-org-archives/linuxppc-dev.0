MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16493.60675.438865.516509@cargo.ozlabs.ibm.com>
Date: Sat, 3 Apr 2004 08:45:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: How did the 2.6 kernel headers get so screwed up?
In-Reply-To: <3AB702B8-84D1-11D8-9FF0-000A95A07384@sands-edge.com>
References: <3AB702B8-84D1-11D8-9FF0-000A95A07384@sands-edge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


John Whitney writes:

> In 2.4 this works beautifully.  Now, in 2.6, I get boatloads of errors:
> redefinitions, admonishments not to use kernel headers from user
> programs, missing constants, you name it.

There is no point discussing this on linuxppc-dev.  Take it to
linux-kernel@vger.kernel.org, but put on your asbestos suit first.

There is a project underway, I believe, to separate out the
definitions that constitute the kernel/user ABI from the definitions
that are purely kernel internals.  I don't know how far they have got.

What I do for things like pppd is have my own sanitized versions of
the necessary kernel headers in the pppd source distribution, and use
those.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
