Subject: Re: Upgrade Blues 2.4.20 Ben H kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ira Weiny <iweiny@acm.org>
Cc: Manuj Dhingra <manuj_dhingra@ae.gatech.edu>,
	linuxppc <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20030312235040.4ca0d0ce.iweiny@acm.org>
References: <20030310164855.GC11462@haar.ae.gatech.edu>
	 <20030312235040.4ca0d0ce.iweiny@acm.org>
Content-Type: text/plain
Message-Id: <1047542929.827.58.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 13 Mar 2003 09:08:50 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Well with your 2.4.15-pre7-ben0 the external monitor was working with my
> TiBook.  Worked quite well.  I did not set the external monitor the same as the
> LCD 'cause the refresh rates were different but I could turn on the external
> and the LCD off and use the external quite well.  So I can tell you that
> worked.

Ok, it's a side effect of initializing the second head from OF. Newer
kernel do that to make sure both heads are properly POSTed on all
cards, but that results in OF setting the card in 2 split heads mode
causing the simple tweak used by m3mirror to fail.

I'm afraid I won't fix this, we really need real support for the
second head for mirroring.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
