Date: Tue, 29 Jan 2002 10:25:45 -0700 (MST)
From: Derrik Pates <dpates@dsdk12.net>
To: benh@kernel.crashing.org
Cc: Christopher Murtagh <christopher.murtagh@mcgill.ca>,
	<yellowdog-devel@lists.yellowdoglinux.com>,
	Eric Leblond <eric@regit.org>, <linuxppc-dev@lists.linuxppc.org>,
	"Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: Support for new Dual G4 1 Gig machines?
In-Reply-To: <20020129123955.29280@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.43.0201291022250.27121-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 29 Jan 2002 benh@kernel.crashing.org wrote:

> I recently spotted a problem with >512Mb (CONFIG_HIGHMEM or not) & SMP that
> is fixed in the current bk _2_4 (2.4.18pre7). I also sent a fix to Marcelo
> that should hopefully be in the next 2.4.18preX release.
>
> You should also use sungem preferably to the old gmac driver.

Maybe you should officially deprecate the GMAC driver in favor of SunGEM,
then? Put something on its line in the config scripts that says
***DEPRECATED***, and something in Configure.help for it that says
something like "Please DO NOT use me, use the SunGEM driver instead!" so
there's no question, so maybe someday it can be dropped?

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
