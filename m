Message-ID: <00512BA4F9D3D311912A009027E9B8F407E48D@NT>
From: Dave Ellis <DGE@sixnetio.com>
To: "'Stephan Linke'" <Stephan.Linke@epygi.de>,
	Thomas Lange <thomas@corelatus.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Potential problem in fec.c for 8xx
Date: Fri, 20 Sep 2002 16:26:35 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stephan Linke wrote:
> normaly this shouldn't happen. By default the interrupts of the PHY chips
> are disabled (see PHY register settings). So when you enable the 8xx
> interrupt nothing should happen.
> So FEC driver has the time to detect the PHY and setup the registers.
After
> the registers are initializes (esp. interrupt mask) the first interrupts
may
> appeare.

This _is_ a problem with the LXT970 PHY (which is still used
on the FADS 860T). There is some discussion and a patch at
 http://www.geocrawler.com/archives/3/4205/2001/12/0/7375297/
and http://lists.linuxppc.org/linuxppc-embedded/200110/msg00107.html

I suppose other PHYs could have similar problems.
I think it is fixed in my tree and also Wolfgang Denk's.
Unfortunately I don't have a clean patch against any current
kernel.

Dave Ellis
~~~~~~~~~~~~~~~~~~~~~~~~~~
SIXNET - "Leading the Industrial Ethernet Revolution"
331 Ushers Road,   P.O. Box 767, Clifton Park, NY 12065 USA
Tel +1 (518) 877-5173   Fax +1 (518) 877-8346
Email me at: dge@sixnetio.com
Detailed product info: www.sixnetio.com
~~~~~~~~~~~~~~~~~~~~~~~~~~


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
