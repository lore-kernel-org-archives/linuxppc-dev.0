Date: Tue, 17 Aug 1999 08:37:18 -0400
From: Mike Lambert <lambert@jeol.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PATCH: Extra brightness off with the XClaim 3D Plus
In-Reply-To: <Pine.LNX.4.10.9908171308490.25292-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.SGI.4.10.9908170826450.12419-100000@davinci.jeol.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 17 Aug 1999, Geert Uytterhoeven wrote:

> On Fri, 13 Aug 1999, Mike Lambert wrote:

> > Thanks Rick, this works as advertised. The XClaim 3D Plus in my B+W G3 400
> > now works properly. Well, except for the mild snow down the left side of
> > the display, but that is a different problem...
> 
> Does the B+W G3 400 really has a RAGE LT PRO? I thought that chip was meant for
> laptops.

In order to use atyfb, I removed the OEM ATI RAGE 128 PCI card from a B+W
G3 400 and installed an ATI XClaim 3D Plus PCI card, which does in fact
use the RAGE LT PRO chip.

However, I see Anthony Tong has released a atyfb patch with RAGE 128
support (Thanks Anthony!), so I think I will be putting the OEM card
back in very soon now.
:-)

Regards,

-- 
Michael Lambert             JEOL USA Inc.
Systems Administration      http://www.jeol.com/





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
