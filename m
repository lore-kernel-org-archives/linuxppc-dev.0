From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bill Fink <billfink@mindspring.com>,
	LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.19-pre8-ben0 acenic driver and 867 MHz G4 sound problems
Date: Thu, 9 May 2002 15:00:38 +0200
Message-Id: <20020509130039.4964@smtp.wanadoo.fr>
In-Reply-To: <20020509103702.528f1a7c.billfink@mindspring.com>
References: <20020509103702.528f1a7c.billfink@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>First, thanks to BenH for his fix in the 2.4.19-pre8-ben0 kernel that
>once again allows booting of the 867 MHz G4.  Unfortunately, I now have
>a new problem as the acenic driver is now broken (using a NetGear GA620
>NIC).  The previously working version was from a 2.4.17-pre2-ben0 kernel.
>I can send a diff between the two sources if that would be of any help.
>
>Also, is there any update on why sound doesn't work on the 867?  It would
>be nice to listen to CDs or watch DVDs on these machines.

Yes, send the diff please, and CC the driver maintainer.

For sound, what makes you think is doesn't work ? (it should actually).

Did you try tweaking the volume with a mixer like gmix or so ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
