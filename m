From: benh@kernel.crashing.org
To: Christopher Murtagh <christopher.murtagh@mcgill.ca>
Cc: <yellowdog-devel@lists.yellowdoglinux.com>,
	Eric Leblond <eric@regit.org>, <linuxppc-dev@lists.linuxppc.org>,
	"Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: Support for new Dual G4 1 Gig machines?
Date: Tue, 29 Jan 2002 13:39:55 +0100
Message-Id: <20020129123955.29280@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.33.0201281521410.9879-100000@blues.wcg.mcgill.ca>
References: <Pine.LNX.4.33.0201281521410.9879-100000@blues.wcg.mcgill.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> .../...
>
> All of the above machines are running 2.4.18pre1 running Apache 1.3.20,
>PHP 4.1.1, Postgres 7.1.3, htdig 3.1.16. Both the 500 and the 800 have 1GB
>of RAM, but the 450 only has 512, so perhaps it is a high-memory with
>networking problem?
>
> So, SMP on the PPC platform has some work needed I'm afraid. I'd be happy
>to help in any testing if someone wants me to, as I'd love to actually use
>that other CPU on my dual 800. :-)

I recently spotted a problem with >512Mb (CONFIG_HIGHMEM or not) & SMP that
is fixed in the current bk _2_4 (2.4.18pre7). I also sent a fix to Marcelo
that should hopefully be in the next 2.4.18preX release.

You should also use sungem preferably to the old gmac driver.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
