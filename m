From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ralph Blach <rcblach@raleigh.ibm.com>
Cc: <paulus@samba.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pci_dma_sync_single
Date: Tue, 16 Oct 2001 16:08:16 +0200
Message-Id: <20011016140816.2321@smtp.adsl.oleane.com>
In-Reply-To: <3BCC324C.9EE9C105@raleigh.ibm.com>
References: <3BCC324C.9EE9C105@raleigh.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>This would probably work, except on Book E platforms, where DR off
>simpley gets you another translaton and NOT
>a physical address.

Well, the last time we discussed about book E, the idea was to use
1:1 translations with DR off that mimmics a physical addressing
(which has also the nice side effect of beeing able to build those
translations on the fly from the TLB miss handler without having to
dig into the page tables).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
