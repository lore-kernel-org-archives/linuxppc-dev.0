Mime-Version: 1.0
Message-Id: <p05101001b84012ac3a2e@[10.0.0.42]>
In-Reply-To: <20011214191920.4144@smtp.adsl.oleane.com>
References: <Pine.LNX.4.21.0112030102320.582-100000@ltgp.iram.es>
 <20011214191920.4144@smtp.adsl.oleane.com>
Date: Fri, 14 Dec 2001 12:41:52 -0800
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Gabriel Paubert <paubert@iram.es>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: 7450 bugs & fixes
Cc: <linuxppc-dev@lists.linuxppc.org>,
	Dan Malek <dan@embeddededge.com>, <paulus@samba.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 8:19 PM +0100 12/14/01, Benjamin Herrenschmidt wrote:

>I don't neither, they didn't give me any detail. Could they catch
>icache misses on the bus and delay incoming tlbie (freezing the emitter)
>when that happen ? I don't know the bus protocol ...

Take this with a grain of salt (*), but I don't recall anything in
the bus protocol which could be used to identify whether a particular
busrt is filling an icache or a dcache miss, much less whether it's
an icache miss which happened during a tablewalk.  It all looks the
same to the outside world.

(*) I've designed hardware, but it was a 750cx and 8260 system and
therefore plain old 60x bus, not MAXbus like the systems in question.
Also, I wasn't the one who had to get deep into the the 60x bus
protocol.  That said, I don't remember anything in 60x which could
identify *why* a transfer was happening, and whenever I've skimmed
over MAXbus docs it looks a lot like a better version of 60x.
--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
