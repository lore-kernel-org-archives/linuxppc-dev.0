From: "Stefan Roese" <stefan.roese@esd-electronics.com>
To: "'Eugene Surovegin'" <ebs@ebshome.net>
Cc: "'Linuxppc-Embedded'" <linuxppc-embedded@lists.linuxppc.org>,
	<benh@kernel.crashing.org>, <akuster@mvista.com>,
	"'Matt Porter'" <mporter@kernel.crashing.org>
Subject: RE: PPC4xx enet driver problem (version 2.0)
Date: Thu, 4 Dec 2003 16:54:21 +0100
Message-ID: <000101c3ba7e$e22be900$0212000a@PCSTEFAN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20031203193545.GB28733@gate.ebshome.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> 2.5 tree has an _old_ driver + some modifications + some 440GX code.
>
> linuxppc-2.4 has a new driver re-written by Ben + some 440GX
> code. Eventually 2.4 version will be merged into 2.5. So it
> is _not_ a dead end, although it has some problems as you noticed.

OK, good to know!

> Currently, Matt Porter is hacking on 440GX support and
> probably he (?) will be the one who will merge 2.4 into 2.5.
>
> I also have something done (mostly some stuff Ben havn't
> finished during re-write, and some NAPI bits) sitting in my
> tree (I'm pretty busy now to finish and push it to Matt :( ).

If you have an updated driver, I would be glad to test it on our 405ep
board.

> I'll try to look at your problem during this weekend, I don't
> have 405ep boards with two EMACs (yet), so I'll try to
> reproduce the problem on 440GP/GX eval boards.

That would be great. Please let me know, if you need any further
infos...

> If you have some fixes feel free to post them here :).

Sorry, I tried to dig deeper into this problem, but without a solution
so far.

Thanks,
Stefan.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
