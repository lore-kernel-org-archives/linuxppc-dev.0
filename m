Message-ID: <20010406115441.A1765@ibrium.se>
Date: Fri, 6 Apr 2001 11:54:41 +0200
From: Samuel Rydh <samuel@waltari.theophys.kth.se>
To: linuxppc-dev@lists.linuxppc.org
Cc: iain@sandoe.co.uk
Subject: Re: MoL (BK)
Reply-To: Samuel Rydh <samuel@theophys.kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Is the MoL BK repo dead?
>(I've been unable to pull from it for ages with either
>"bk pull" (just comes returns) or "bk opull" (says it
>can't find the server).  Couldn't telnet to
>it either...

No - the MoL BK server has just been moved:

 bk clone bk://zorn.theophys.kth.se:5000 mol

There is also rsync access:

 rsync -az zorn.theophys.kth.se::mol mol-rsync

/Samuel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
