Date: Wed, 19 Sep 2001 17:12:48 -0700
From: Tom Rini <trini@mvista.com>
To: Matt Porter <mporter@mvista.com>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: BitKeeper and linuxppc_2_4_devel
Message-ID: <20010919171248.G17996@entropy.crashing.org>
References: <3BA86732.363312A4@imc-berlin.de> <20010919033824.B5042@cx258813-a.chnd1.az.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010919033824.B5042@cx258813-a.chnd1.az.home.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 19, 2001 at 03:38:24AM -0700, Matt Porter wrote:
> On Wed, Sep 19, 2001 at 11:36:50AM +0200, Steven Scholz wrote:
> > But "bk clone http://source.mvista.com/linuxppc_2_4_devel linux/"
> >
> > results today (!?) in
> >
> > drainErrorMsg: Unexpected response:
> > <!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
> >
> > Has anyone else the same problem?
>
> Yes.  Just noticed it yesterday...somebody will get it fixed.

Okay.  This specific problem has a simple cause.  source.mvista.com runs
an actual webserver.  So, if you're behind a strict proxy:
bk pull http://ppc.bkserver.net/tree_name
If there's enough interest and people affected willing to test, I'll
see if we can setup some automagic redirect, but I suspect this will
fail since data would still be on port 14360.

> > BTW which one has the most recent source: ppc.bkserver.net oder
> > source.mvista.com???
>
> source.mvista.com is a mirror of ppc.bkserver.net.  I'm using
> ppc.bkserver.net for now.

Okay.  Regarding the flakiness Matt noticed, I upgraded bk again, and
if you don't get something similar to this:
$ bk version
BitKeeper/Free version is bk-2.0pre3.1 20010918150405 for x86-glibc22-linux
Built by: lm@glibc22.bitmover.com
Built on: Tue Sep 18 10:48:28 PDT 2001

Go ahead and upgrade and try again.

--
Tom

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
