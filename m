Date: Sat, 5 May 2001 09:44:48 -0700 (PDT)
From: Paul White <pwhite@networkrobots.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Modules on 2.4.0 PPC Linux
Message-ID: <Pine.LNX.4.21.0105050940010.13276-100000@stimpy.networkrobots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All,

I currently have 2.4.0 working on a PPC 7400 embedded board,
however modules do not seem to be working.  When I attempt
to load a modules, I receive several unresolved symbols,
including printk(), schedule(), sk_free(), kmem_cache_alloc(),
etc..  Since these are all global functions always compiled
in, they should be found.

Anyone have any ideas?

Thanks....

Paul W.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
