Subject: Re: insmod ipv6 freezes current linuxppc-2.5 and 2.5-benh
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Harald Welte <laforge@gnumonks.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20031130155530.GK26749@obroa-skai.de.gnumonks.org>
References: <20031120201249.GB29432@sunbeam.de.gnumonks.org>
	 <1069386878.876.49.camel@gaston>
	 <20031121153314.GC23224@sunbeam.de.gnumonks.org>
	 <20031130155530.GK26749@obroa-skai.de.gnumonks.org>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1070380779.5675.16.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Tue, 02 Dec 2003 16:59:39 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-11-30 at 16:55, Harald Welte wrote:
> On Fri, Nov 21, 2003 at 04:32:52PM +0100, Harald Welte wrote:
> >
> > On Fri, Nov 21, 2003 at 02:54:38PM +1100, Benjamin Herrenschmidt wrote:
> >
> > > Interesting. Same machine here and I use 2.6 everyday :)
> >
> > The problem seems to be gcc-related. Debian testing seems to have
> > installed gcc-3.3.2 (yes, maybe not the best compiler for a kernel
> > anyway) per default.
> >
> > compiling the same kernel with gcc-2.95 results in a working ipv6
> > module.
>
> I did some more testing:
>
> Compiles with gcc-3.3.2 and gcc-3.2.3 result in a broken kernel,
> gcc-3.0.4 and gcc-2.95.4 work fine.

I've been running Ben's tree built with gcc-3.3 for a while (since
test7-ish) without problems:

daenzer@thor|16:55:01> cat /proc/version                               ~
Linux version 2.6.0-test11-benh (daenzer@thor) (gcc version 3.3.2
(Debian)) #1 Sat Nov 29 14:07:02 CET 2003
daenzer@thor|16:55:43> lsmod|grep ip                                   ~
ipv6                  290072  15


What version of binutils do you have? Current from testing here.


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Software libre enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
