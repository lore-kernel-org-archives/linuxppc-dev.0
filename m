Date: Mon, 29 Jan 2001 23:54:02 +0000
Subject: Re: network stack oops 2.4.1/gcc 2.95.3 
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: David Edelsohn <dje@watson.ibm.com>
Cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010129235359.1B26D2EFD0@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi David,

Mon, Jan 29, 2001, David Edelsohn wrote:
>>> "Iain Sandoe" writes:
> Iain> It is not a regression test.  It would not be particularly easy, either
to
> Iain> put 2.95.2 back up and wind back the system to the build conditions...
> Iain> but the version used was 2.95.3-test2. and the bk pull was 2.4.1-pre10.
>
>  A regression is different from a regression test.  I never called
> it a regression test.

RTFM(ail) properly Iain ;)

>  I do not mean rewinding all of the way to gcc-2.95.2, but to
> Franz's patched version of GCC prior to the gcc-2.95.3 changes.

OK. It might be possible - I have a build timestamp on the kernel (I keep
the last four or five builds) and I guess I could somehow track down which
revs to get from bk.  I still have the previous glibc & gcc rpms.

However, (see below) I will only do this if someone really believes they
will get useful info... I'm mid-way through a fairly large chunk of work
ATM.

>  I am just trying to narrow down whether this is something new.

I believe so.  Because I really think I'd built that particular pull before
I upgraded the tool-chain.  BUT because it only happens under fairly unusual
circumstances (for my set-up) I can't be 100% sure.

Also it involves a depressingly large amount of system context: kernel, X,
inetd, da-da-da...

If it happens again - I'll see if I really have a genuine Illegal
Instruction in the code stream (or I'm just trying to execute a format
string ;)

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
