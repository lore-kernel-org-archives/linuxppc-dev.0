Date: Tue, 29 Jan 2002 15:06:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Derrik Pates <dpates@dsdk12.net>
Cc: benh@kernel.crashing.org,
	Christopher Murtagh <christopher.murtagh@mcgill.ca>,
	yellowdog-devel@lists.yellowdoglinux.com,
	Eric Leblond <eric@regit.org>, linuxppc-dev@lists.linuxppc.org,
	"Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: Support for new Dual G4 1 Gig machines?
Message-ID: <20020129220619.GH25973@opus.bloom.county>
References: <20020129123955.29280@mailhost.mipsys.com> <Pine.LNX.4.43.0201291022250.27121-100000@andromeda.dsdk12.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.43.0201291022250.27121-100000@andromeda.dsdk12.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 29, 2002 at 10:25:45AM -0700, Derrik Pates wrote:
>
> On Tue, 29 Jan 2002 benh@kernel.crashing.org wrote:
>
> > I recently spotted a problem with >512Mb (CONFIG_HIGHMEM or not) & SMP that
> > is fixed in the current bk _2_4 (2.4.18pre7). I also sent a fix to Marcelo
> > that should hopefully be in the next 2.4.18preX release.
> >
> > You should also use sungem preferably to the old gmac driver.
>
> Maybe you should officially deprecate the GMAC driver in favor of SunGEM,
> then? Put something on its line in the config scripts that says
> ***DEPRECATED***, and something in Configure.help for it that says
> something like "Please DO NOT use me, use the SunGEM driver instead!" so
> there's no question, so maybe someday it can be dropped?

Well, I think the plan is to simply rm the file in 2.5.x :)  Dropping it
from 2.4.x is probably a bad idea, since it's not broken for old things.
The defconfigs should probably be updated tho. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
