Message-ID: <DF2142DFD5ECD311BA1900104B943A97A4ED20@roche-exg1.rochester.adaptivebroadband.com>
From: "Ruhland, Paul" <pruhland@microwavedata.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCMCIA on MBX860 and NFS stale
Date: Fri, 8 Dec 2000 16:40:27 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've gotten the pcmcia card services ( pcmcia-cs-3.1.22 ) running on an
MBX860.  It correctly identifies and inserted card and loads the appropriate
driver.  Currently, I'm testing with a 3com lan card.  After the drivers are
loaded, eth1 ( eth0 is the onboard ethernet ) is configured and working.  I
can ping both ports successfully.

However, during this whole process my nfs root filesystem goes stale.  Is
there anyway to prevent this?

--------------
Paul Ruhland
Rochester, NY 14620, USA


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
