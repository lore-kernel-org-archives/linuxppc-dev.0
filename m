Message-ID: <20021023130637.80868.qmail@web9502.mail.yahoo.com>
Date: Wed, 23 Oct 2002 06:06:37 -0700 (PDT)
From: Pete McCormick <pete261@yahoo.com>
Subject: Re: 8260 CPM commands, need better resource ctrl?
To: Dan Malek <dan@embeddededge.com>,
	Hans Feldt <Hans.Feldt@uab.ericsson.se>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3DB58D93.50008@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

> different contexts in which drivers send these commands.  It
> doesn't make sense for a driver to continue without waiting for
> the command to complete, so there isn't any need to wait for this
> prior to sending a command.

I think that a driver should not wait forever for a CPM command to complete, as
this could possibly halt the entire kernel.  Granted, if this happens then the
state of the system is flaky at best, but it might still be possible to
function, maybe even enough to debug the real problem.

Since the CPM is a shared resource between different drivers, I don't think it
is such a bad idea to have some software help in sharing it, as opposed to just
hoping everyone behaves properly.

Actually, on a complicated CPU such as the 8260, there are many common
resources that are shared that might be better protected in software, e.g. io
port pins, internal dpram, baud rate generators, timers, mutually exclusive
features, etc.

Along the same lines, what is the current vision of future linux support for
the 8260?

Pete


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
