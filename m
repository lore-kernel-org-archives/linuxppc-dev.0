Date: Sat, 24 Apr 1999 20:40:22 -0600 (MDT)
From: Dan Burcaw <dburcaw@terraplex.com>
To: Adam Powell <hazelsct@mit.edu>
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: Blue & White G3s
In-Reply-To: <37227A7F.9BD5D1C4@mit.edu>
Message-ID: <Pine.LNX.3.96.990424203947.27756B-100000@newhope.terraplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



The driver didn't work on Linux/PPC. It now does. Our patches have been
sent to Cort Dougan for approval. 

On Sat, 24 Apr 1999, Adam Powell wrote:

> Dan Burcaw wrote:
> 
> > Folks,
> >
> > Our in-house development team has successfully ported the CMD646
> > driver to the Linux/PPC kernel, offering the much anticipated support
> > for the primary ATA chain. This driver supports the ultra-DMA features
> > of the chipset, allowing data transfer in excess of 30MB per second.
> > The Blue & Whites are now fully functional with ATA, SCSI, and USB.
> 
> Er, cool!  But I've been using a CMD646 IDE kernel driver since on my AlphaPC
> LX164 533 MHz since last October (2.1.116, I believe).  Is this your driver,
> or have you since reinvented the wheel, or was it Alpha-specific, or am I
> missing something?
> 
> Zeen,
> 
> -Adam      "...the firmament sheweth His handywork" (Ps 19:1)    ///
> ............................................................__  ///|
> Adam "Cold Fusion" Powell IV Firmament Science & Engineering\\\///_|
> http://lyre.mit.edu/~powell/ Standing on the Solid State Rock\XX/  |MIGA
> 
> 
> 
> 
> 
> 
> 
> 


Dan

Terra Soft Solutions, Inc.
 email: dburcaw@yellowdoglinux.com
 website: http://www.yellowdoglinux.com/



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
