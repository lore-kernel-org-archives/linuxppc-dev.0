Date: Tue, 16 Jul 2002 12:12:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Remco Treffkorn <remco@rvt.com>
Cc: stefan.eletzhofer@eletztrick.de, linuxppc-dev@lists.linuxppc.org
Subject: Re: Symbol versioning problem
Message-ID: <20020716191248.GI20027@opus.bloom.county>
References: <200207101429.39539.remco@rvt.com> <20020715110417.A3630@gonzo.local> <200207161121.50509.remco@rvt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200207161121.50509.remco@rvt.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 16, 2002 at 11:21:50AM -0700, Remco Treffkorn wrote:
>
> On Monday 15 July 2002 02:04, Stefan Eletzhofer wrote:
> ...
> > Hmm, compiled this kernel with no problems for my PowerBook. My gcc is a
> > 2.4.95, depmod is 2.4.15. And it a grep of /proc/ksyms reveals
> > c00180f8 __out_of_line_bug_R8b0fd3c5
> >
> > Wild guess: do you have
> > CONFIG_MODVERSIONS=y
> > in your .config?
> >
> > just my .02$ anyway :)
> >
>
> Yes. I even checked, to be sure :-)
>
> Since there was no storm of "me too"s, I assume that it's my particular
> system. I'll spend some time to figure it out, and will let you know...

Well, have you tried backing up your .config, running 'make distclean',
moving your config back (and re running your favorite config program)
and trying again?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
