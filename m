Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Poor 8260 FCC Ethernet performance
Date: Thu, 30 May 2002 20:42:31 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFCEOADHAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <F1BED55F35F4D3118C0F00E0295CFF4DFFA04F@mail.mediatrix.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> The 8260 Ethernet controller needs to know about the duplex mode in which
> the PHY operates. The driver sets it to half duplex by default, and needs
> the feed back of the PHY to set it to full duplex.
>
> As you may know, the hub always operates in half duplex, while the switch
> usually operates in full duplex, if it is directly connected to your unit,
> and your PHY accepts to negociate to full duplex.
>

Yes, the source code has been modified to force full-duplex.
(fcc_restart(dev,1) if I remember correctly :) In fact, before this change
was made Ethernet communications did not work at all. (At least it would not
get past bootp) I searched for something that looked like it was speed
related but found nothing. (Other than the MII reporting)

Other ideas?

BTW: We are using a BCM switch for our PHY. The interface to the processor
is always full-duplex, 100BT regardless of the external connections. Hence
the no MII PHY option.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
