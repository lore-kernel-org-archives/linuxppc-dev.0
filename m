Message-ID: <AF4C1F8C5306D111AD5F0000F8662ED308F8835C@RED-MSG-41>
From: "Aaron Burt (Volt Computer)" <a-aburt@microsoft.com>
To: "'Vinai Roopchansingh'" <vroopcha@post.its.mcw.edu>,
        linuxppc-user@lists.linuxppc.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: RE: PPP PCI client ??
Date: Wed, 6 Jan 1999 18:18:13 -0800 
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> From: Vinai Roopchansingh [mailto:vroopcha@post.its.mcw.edu]
(snip)
> Has this been done already and is there a chipset for the
> modems that are more "favoured" that others?

The Linux-kernel folks get this question pretty often.  As far as anyone can
tell, all of the PCI internal modems use weird proprietary serial ports or
are proprietary Winmodem-type devices.  Until specs are released or
reverse-engineered (many have tried), and someone goes to the trouble of
writing kernel drivers, no go.  But if someone does it on x86-PCI (most
likely platform), it should adapt to PPC-PCI.  And if it looks like a modem,
PPP will use it.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
