Message-ID: <3BD0DBAB.8A7B1461@mvista.com>
Date: Fri, 19 Oct 2001 22:04:27 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ralph Blach <rcblach@raleigh.ibm.com>, paulus@samba.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: pci_dma_sync_single
References: <3BCC324C.9EE9C105@raleigh.ibm.com> <20011016140816.2321@smtp.adsl.oleane.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> Well, the last time we discussed about book E,

I'm kinda planning to roll a whole new book E arch tree so we can
take advantage of their features without hacking up the traditional
PowerPC.  There are a variety of options that will be necessary to
fit a wide range of embedded applications for which they are
specifically designed.  While we can make Book E fit into the
traditional PowerPC tree by forcing some fixed rules, it wouldn't
be fair to their flexibility or performance options.

I've got a couple of things to finish up and would like to start
discussing this in the next couple of weeks, as more documentation
and perhaps some hardware arrives on my doorstep.

Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
