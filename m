Message-ID: <3DF0A39D.2090401@intracom.gr>
Date: Fri, 06 Dec 2002 15:18:21 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Regarding consistent_alloc
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

Can someone tell what is the deal with these functions?

consistent_alloc et. al. are very useful to me now that I'm
cleaning up my QMC driver. But they are exported.

Is there any reason why they are not exported for use by
modules?

Also they appear to be tied to the PCI bus, a reduntant
dependancy IMHO.

Regards

--
Pantelis Antoniou
INTRACOM S.A. Greece

"> I read slashdot because it's so hard to find
 >> anything else intelligent to read.

Keep searching..."
-- as seen on slashdot --


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
