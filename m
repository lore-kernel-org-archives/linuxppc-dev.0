Message-ID: <36A275C4.8EC0B1E0@wanadoo.fr>
Date: Mon, 18 Jan 1999 00:44:04 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Adam Sherman <adams@magma.ca>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: PC Card Ethernet Support in the Installer
References: <v04103c00b2c7f034e339@[206.191.4.153]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Adam Sherman wrote:
> 
> Does the installer (pre-R5) have PC Card Ethernet support? Or do I
> have to do a HD install. I have a PowerBook 2400c with a Kingston
> (NE2000) card.

You have to use a kernel with the right driver built in (don't know if
this exists for your card). The installer relies on the kernel for this.
And it is better to have the driver compiled in the kernel, not as a
module, because module loading is not working very well in the pre-R5
installer.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
