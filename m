Date: Mon, 10 May 2004 15:22:36 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Efficient handling of RTP frames?
Message-ID: <20040510222236.GB25350@gate.ebshome.net>
References: <20040510205808.GA4313@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040510205808.GA4313@mars.ravnborg.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, May 10, 2004 at 10:58:08PM +0200, Sam Ravnborg wrote:
> We (my company) are looking into a solution for transporting a high amount
> of RTP packets across a single CPU. A 82xx, presumeably a 8270.
> With high amount of RTP packets we are talking about 10 to 20.000 packets
> per second with a payload size of ~64 bytes each (on top of UDP header).

Hmm, I'm a little surprised by this number - 64 bytes. Most common is 20ms
RTP payload and for and ordinary voice traffic it yields 160 byte payload, but
probably your application is somewhat special :).

For high packet rates you might be interested in NAPI enabled network driver.

Eugene.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
