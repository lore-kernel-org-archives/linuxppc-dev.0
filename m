From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bill Fink <billfink@mindspring.com>
Cc: "David S. Miller" <davem@redhat.com>,
	<linuxppc-dev@lists.linuxppc.org>, Anton Blanchard <anton@samba.org>
Subject: Re: GigE Performance Comparison of GMAC and SUNGEM Drivers
Date: Tue, 20 Nov 2001 13:02:32 +0100
Message-Id: <20011120120232.6517@smtp.adsl.oleane.com>
In-Reply-To: <Pine.LNX.4.33.0111200110210.28304-100000@gwiz.nasa.atd.net>
References: <Pine.LNX.4.33.0111200110210.28304-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I'd consider it much more than nice.  Since the whole point of GigE
>is better performance, taking such a huge peformance/CPU hit would
>be extremely bad.  OTOH, I probably won't be using the built-in GigE
>hardware anyway because of its apparent performance ceiling of about
>660 Mbps and its lack of jumbo frame support.

Well, I think we may get overall better perfs once we have this
fixed, and (David, can you confirm ?), I think jumbo frames can
be supported.

So there is a small issue with the Tx ring that I'll fix asap
but it doesn't explain your problem, you are getting way too
much interrupt, possibly those rxmac/txmac interrupts I've noticed
here.

I'll investigate a bit and send you a patched driver.

Thanks for taking the time for testing,

Ben


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
