Date: Sun, 6 Dec 1998 16:02:16 -0500 (EST)
From: Thomas Riemer <triemer@apt4g.a3nyc.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: PCI base_address
In-Reply-To: <Pine.LNX.3.96.981206155643.12703J-100000@apt4g.a3nyc.com>
Message-ID: <Pine.LNX.3.96.981206155922.12703K-100000@apt4g.a3nyc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


There is a field in pci_dev called base_address
(include/linux/pci.c)

The USB stuff seems to be referencing base_address[4] in the UHCI version
 (Intel)
and 
  base_address[0] in the OHCI version...   (non -intel)

I'm a bit confused as to why pci.c would have base_address[6] as a 
member to start with - and just as confused as to why there would
be a difference between architectures.  

Anyone have any comments that might help clarify this confusion?

-Tom




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
