Subject: Re: insmod ipv6 freezes current linuxppc-2.5 and 2.5-benh
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Harald Welte <laforge@gnumonks.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20031213090332.GH8950@obroa-skai.de.gnumonks.org>
References: <20031120201249.GB29432@sunbeam.de.gnumonks.org>
	 <1069386878.876.49.camel@gaston>
	 <20031121153314.GC23224@sunbeam.de.gnumonks.org>
	 <20031130155530.GK26749@obroa-skai.de.gnumonks.org>
	 <1070380779.5675.16.camel@thor.asgaard.local>
	 <20031213090332.GH8950@obroa-skai.de.gnumonks.org>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1071398331.1642.105.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Sun, 14 Dec 2003 11:38:51 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-12-13 at 10:03, Harald Welte wrote:
>
> The actual problem seems not to be an infinite loop, but rather a very
> long loop.   IF you wait long enough, it will eventually work.  A
> significant delay (i.e. assumed long loop) is also observed while
> loading any module.  Something like 10 - 15 seconds for every module
> that I'm loading during startup (ipv6, tulip, dmasound_pmac, ...)
>
> The machine is completely frozen during that loop, not even the cursor
> is blinking anymore.
>
> compiling the kernel with gcc 2.95 or 3.0 removes those symptoms.

As I'm not seeing this, you may want to compare your .config to mine,
which is http://penguinppc.org/~daenzer/config-2.6.0-test11-benh


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Software libre enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
