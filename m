Date: Sun, 28 Oct 2001 09:40:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Driver Hell: was Re: GeForce on PPC == _no work_
Message-ID: <20011028094057.H15768@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011028125007.MHAN10438.tomts12-srv.bellnexxia.net@there> <20011028145435.7084@smtp.wanadoo.fr> <20011028151111.JZNC28233.tomts15-srv.bellnexxia.net@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011028151111.JZNC28233.tomts15-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Oct 28, 2001 at 11:13:44AM -0500, Kevin B. Hendricks wrote:

> - new driver for adaptec scsi drivers does not work (old ones do)
>
> - the new tulip ethernet driver does not really support Lite-On PNIC2
>   negotiation (seems to have been hardwired to 100mb?).    Again, at
>   least the old becker driver did work at 10baseT-HD.

These are unrelated to Darwin anyhow.  The second one is because the
tulip driver isn't being as heavily tested as it used to be and Jeff
Garzik is (was) in the process of moving.  2.4.5-final or so broke tulip
on numerous cards, x86 and ppc.  CONFIG_DE4X5 should still work tho.

You're having no luck w/ the old aic7xxx driver?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
