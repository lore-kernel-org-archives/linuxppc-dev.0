MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 8260 CPM DP ram free function
Date: Mon, 24 May 2004 11:03:49 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DAE3@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Tom Rini" <trini@kernel.crashing.org>,
	"Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I suppose once Dan's comments are addressed, since I thought
> he's been the biggest objector to all of the previous
> implementations (or, my memory is faulty, and every one of
> them just fell on the ground), we can push this out, at least
> for cpm2 stuff.

I have fixed the #ifdefs Dan complained about, but I cannot really do
much about changing hostalloc to kfree for the stuff in the kernel,
since hostalloc gets called a few times before kalloc is initialized.

What else should I do before resubmitting?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
