Message-ID: <AF4C1F8C5306D111AD5F0000F8662ED308F8836F@RED-MSG-41>
From: "Aaron Burt (Volt Computer)" <a-aburt@microsoft.com>
To: "'Cort Dougan'" <cort@persephone.cs.nmt.edu>, linux-ppc@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: RE: getting VGER sources - 2.2.0-pre7 PReP success
Date: Fri, 15 Jan 1999 23:15:35 -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> From: Cort Dougan [mailto:cort@persephone.cs.nmt.edu]

> I put a tarball up at 
> ftp://linuxppc.cs.nmt.edu/pub/linuxppc/kernel-sources/ 
> of the vger source.  I'll try to keep it up-to-date until anon-cvs for
> vger returns.

Thanks!  After a couple false starts, it's running my PowerStack jim-dandy.
The Tulip driver doesn't work, but the generic DEC driver works fine.  DHCP
and everything.

Sound is compiled as a module, I'm just trying to get it working now.

My Powerstack had a habit of freezing up.  I think it was the network
trashing the keyboard controller.  This seems to work better so far.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
