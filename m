Message-ID: <19981207184600.A5639@merelda.uiuc.edu>
Date: Mon, 7 Dec 1998 18:46:00 -0600
From: anthony tong <atong@uiuc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF68_FBDev under MkLinux?
References: <Pine.LNX.4.03.9812070957590.31794-100000@mercator.cs.kuleuven.ac.be> <Pine.LNX.3.96.981207114602.20658A-100000@globegate.utm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.96.981207114602.20658A-100000@globegate.utm.edu>; from David A. Gatwood on Mon, Dec 07, 1998 at 11:46:40AM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David A. Gatwood (Mon, Dec 07, 1998 at 11:46:40AM -0600):
> On Mon, 7 Dec 1998, Geert Uytterhoeven wrote:
> > Doesn't the stuff in <asm/vc_ioctl.h> come from MkLinux?
> 
> Maybe.  I'm not saying the linux server part doesn't have the support,
> just that the mach kernel drivers don't, AFAIK.  :-)

The framework is already in the mach kernel. In fact, there is video
initialization code for the pdm (the [6-8]100's)?? The other drivers
are only partially implemented.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
