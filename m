Subject: RE: Poor 8260 FCC Ethernet performance
From: Gary Thomas <gary@mlbassoc.com>
To: Rune Torgersen <runet@innovsys.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DAF8@ismail.innsys.innovsys.com>
References: 
	 <DCEAAC0833DD314AB0B58112AD99B93B06DAF8@ismail.innsys.innovsys.com>
Content-Type: text/plain
Message-Id: <1086820067.3643.1766.camel@hermes>
Mime-Version: 1.0
Date: Wed, 09 Jun 2004 16:27:48 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2004-06-09 at 16:19, Rune Torgersen wrote:
> Does the FCC performance issue have something to do with the fact that
> the current FCC drivers in linux puts the buffer descriptors in main
> memory and not in dual port?

I hope not since the latest word from Motorola is that they need to be
in main memory - at least on the latest processors, the CPM DPRAM can't
handle cache bursts (or so I've been told - I have a least one customer
that has experienced this)

--
Gary Thomas <gary@mlbassoc.com>
MLB Associates


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
