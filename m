Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 8260 CPM DP ram free function
Date: Fri, 21 May 2004 16:41:31 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DAE1@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Did you run 'make clean' before trying?  Perhaps there's
> still a bug when you add exports to a file that previously
> didn't have any..

Tried that, it did not work. I get Unknown symbol errors when loading
the module.

BTW there is a an error in the patch file I sendt... No Idea how that
snuck in there before I did the diff..., line 103 of commproc.c has one
too many closing parens

-	init_rt_alloc(&dp_heap, (void*)dp_alloc_base, CPM_DATAONLY_SIZE
));
+	init_rt_alloc(&dp_heap, (void*)dp_alloc_base, CPM_DATAONLY_SIZE
);

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
