From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>,
	<yellowdog-devel@lists.yellowdoglinux.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: some questions on new dual 1Gig G4's support?
Date: Sun, 3 Feb 2002 13:04:26 +0100
Message-Id: <20020203120426.22252@smtp.wanadoo.fr>
In-Reply-To: <20020202201734.KLTB18463.tomts7-srv.bellnexxia.net@there>
References: <20020202201734.KLTB18463.tomts7-srv.bellnexxia.net@there>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Thanks!  I see you have hit the big time!  The /. inerview article was
>great!  Now I can say I actually know someone famous!  ;-)
>
>One last question:
>
>The 7455 errata basically says to disable the L2 hardware prefetch engine
>(MSSCR0[L2PFE] = 0 when disabling the L1 data cache.
>
>It goes on to say that the L1 data cache may be disabled during cache
>flushing on some systems or be disabled upon startup.
>
>Do we disable L1 cache's during cache flushing?  If so were should I be
>looking for this code to get the workaround in place?

I don't think we disable L1 except when changing L2CR value or when
going to sleep.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
