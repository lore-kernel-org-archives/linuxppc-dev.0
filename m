From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14731.43305.438998.169473@argo.linuxcare.com.au>
Date: Sat, 5 Aug 2000 15:42:01 +1000 (EST)
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: Tom Gall <gall@rochcivictheatre.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Getting things in...  Was: Re: shifts on 64bit ints
In-Reply-To: <20000804174953.16973@mailhost.mipsys.com>
References: <398AEA0C.329AB669@rochcivictheatre.org>
	<20000804174953.16973@mailhost.mipsys.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt writes:

> I'm an horribly bad web designer, but one cool thing to do if someone is
> good at it, would be a web-pased patch repository. You send patches with
> a web form (eventually an upload mecanism) along with your  email, a
> comment, etc..., they get assigned a patch number automatically, anybody
> can consult the database, and people with write access to BK can mark
> them (accepted, refused, postponed, ... along with a comment) once they
> have been handled.

Sounds exactly like the jitterbug site that Andrew Tridgell set up for
the Linux kernel.  Linus tried it for a while but unfortunately
eventually decided he didn't like it enough.  But for the rest of us
it was great.  Tridge even put in a "test patch" button for Linus that
would rsync the current kernel tree, automagically unpack/decompress
the patch, apply it and report any errors.  I could ask Tridge to set
up something like this for us.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
