From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bill Fink <billfink@mindspring.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: sungem driver won't compile on latest benh kernel
Date: Thu, 1 Nov 2001 11:52:24 +0100
Message-Id: <20011101105224.4312@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.33.0111010200230.11565-100000@gwiz.nasa.atd.net>
References: <Pine.LNX.4.33.0111010200230.11565-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>When trying to do a make modules on the latest benh kernel (2.4.14-pre5-
ben0),
>the compile of the sungem driver fails spectacularly.  It looks like there
>are missing include files linux/mii.h and linux/ethtool.h, plus undefined
>variables and labels.  It was more than I wanted to mess with.  I was
>interested in comparing the GigE performance of the gmac and sungem drivers,
>but I guess I'll wait.

I'm working on it and didn't finish yet.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
