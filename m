Date: Tue, 25 Mar 2003 23:05:34 -0500
From: Daniel Jacobowitz <drow@mvista.com>
To: Kalpesh Jasapara <kjasapara@yahoo.com>
Cc: gdb@sources.redhat.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: GDB server and threaded application
Message-ID: <20030326040533.GA26741@nevyn.them.org>
References: <20030326035830.20755.qmail@web14601.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030326035830.20755.qmail@web14601.mail.yahoo.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 25, 2003 at 07:58:30PM -0800, Kalpesh Jasapara wrote:
> Hello,
>
> I am having a problem with remote gdb debugging
> using gdbserver to work with multi threads.
> The command "info threads" shows only one thread.
>
> I am using glibc 2.1.3, powerpc-linux-gdb 5.3,
> powerpc-linux-gcc 2.9.5
>
> Observed that qfThreadInfo packet response contains
> only
> one thread, not a list of all the threads in our
> application.
>
> How does the all_threads list get populated with the
> other
> threads?
>
> Is this feature supported with the versions that we
> are using?

I recommend you search the archives for this mailing list.  I've
still not written a good FAQ about this but I've answered the question
five or six times.

In short, probably your target libraries are not properly available to
the host GDB.

--
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
