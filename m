Date: Tue, 6 Aug 2002 17:29:34 -0700
From: Larry McVoy <lm@bitmover.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Tom Rini <trini@kernel.crashing.org>,
	acurtis@directvinternet.com,
	"David M?ller (ELSOFT AG)" <d.mueller@elsoft.ch>,
	linuxppc-dev@lists.linuxppc.org, lm@bitmover.com
Subject: Re: Problem with bk repository?
Message-ID: <20020806172934.C17145@work.bitmover.com>
References: <3D4FEA26.1070403@elsoft.ch> <NCBBIINEHIPFGJPLBEIFEEGMDKAA.acurtis@directvinternet.com> <20020806161339.GB714@opus.bloom.county> <20020807001252.GF5012@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020807001252.GF5012@zax>; from david@gibson.dropbear.id.au on Wed, Aug 07, 2002 at 10:12:52AM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[root@bitmover cort-20010106071759-19793-5c81b698cda31832]# bk takepatch -avvLf PENDING/2002-08-05.01
Applying   1 revisions to ChangeSet
Applying   2 revisions to new file drivers/mtd/maps/beech-mtd.c
Applying   1 revisions to drivers/mtd/maps/Config.in
Applying   1 revisions to drivers/mtd/maps/Makefile
takepatch: 5 new revisions, 3 conflicts in 4 files
bk: takepatch.c:268: getConfig: Assertion `exists(".." "/BitKeeper/etc/SCCS/s.config")' failed.
Aborted

Looks like we have a busted tree, I'll see what I can do.
--
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
