Date: Tue, 20 Nov 2001 11:50:15 -0800 (PST)
Message-Id: <20011120.115015.10305322.davem@redhat.com>
To: benh@kernel.crashing.org
Cc: billfink@mindspring.com, linuxppc-dev@lists.linuxppc.org,
	anton@samba.org
Subject: Re: GigE Performance Comparison of GMAC and SUNGEM Drivers
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011120120232.6517@smtp.adsl.oleane.com>
References: <Pine.LNX.4.33.0111200110210.28304-100000@gwiz.nasa.atd.net>
	<20011120120232.6517@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


   From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
   Date: Tue, 20 Nov 2001 13:02:32 +0100

   Well, I think we may get overall better perfs once we have this
   fixed, and (David, can you confirm ?), I think jumbo frames can
   be supported.

No, the GEM chips are broken and don't support jumbo frames.

Franks a lot,
David S. Miller
davem@redhat.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
