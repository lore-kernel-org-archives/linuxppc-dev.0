Message-ID: <38C35732.404A6B22@amberdata.demon.co.uk>
Date: Mon, 06 Mar 2000 06:58:58 +0000
From: David Monro <davidm@amberdata.demon.co.uk>
MIME-Version: 1.0
To: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>, paulus@linuxcare.com
Subject: insw/outsw in ide.h
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Is there any PPC platform that needs to use a byte-swapping insw/outsw in
> the IDE driver?  (I can't see why any platform would, but you never
> know...)

Yes - the IBM 850 does. Otherwise the firmware doesn't understand the
partition table and the CD drive doesn't work.

Cheers,

	David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
