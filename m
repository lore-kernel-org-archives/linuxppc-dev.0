Date: Mon, 14 Feb 2000 15:33:13 -0600 (CST)
From: Nathan Ingersoll <ningerso@d.umn.edu>
To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Bug in acceled Xpmac?
In-Reply-To: <200002141749.LAA13446@mail.d.umn.edu>
Message-ID: <Pine.SO4.4.02.10002141521440.2109-100000@bulldog5.d.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The problem still exists in this version. Also, this machine doesn't have
USB. It's a straight 6500/250, no upgrades or add-ons. The program just
tries to remap the first button to a different button.

The server reports making the change, but the mouse button behavior
doesn't change. I know the server is acknowledging the change, because the
program calls XGetPointerMapping to set it's initial values. Exiting the
program and starting it again reports the same values that were set at the
end of the last run.

---------------------------------------------------------------------------
|   Nathan Ingersoll             |   Computer Science/Mathematics         |
|   mailto: ningerso@d.umn.edu   |   University of Minnesota-Duluth       |
|   http://umn.edu/~ningerso     |   http://www.d.umn.edu                 |
---------------------------------------------------------------------------

On Mon, 14 Feb 2000, Kevin_Hendricks wrote:

> Hi,
>
> Yes, thjere was a serious mouse bug problem with usb mice fixed in
> Xpmac rev8 and later versions.  It seems that the accelerated Xpmac
> was not properly setting an accurate time for the mouse button
> events.
>
> Please try upgrading to Xpmac rev9 and try again (see
> http://www.linuxppc.org/BlueG3/ for a link.
>
> If you still have a mouse problem with Xpmac rev9, please let me
> know.
>
> Thanks,
>
> Kevin
>
> >It looks like the accelerated Xpmac that was released in January
> may have
> >a bug in mouse handling.
> >
> >I was working on a small epplet for one button mouse users to make
> better
> >use of enlightenment. When using the version of Xpmac that shipped
> with
> >LinuxPPC 1999 Q1 it worked fine. But when using the recent
> accelerated
> >version, the mouse functionality wouldn't change.
> >
> >XGetPointerMapping returns the values that were set, but it doesn't
> seem
> >to be updating the way it handles the button.
> >
> >Has anyone else seen similar behavior or know of a fix? I attached
> the
> >source of my program for anyone interested in trying it out.
> >
> >-------------------------------------------------------------------
> --------
> >|   Nathan Ingersoll             |   Computer Science/Mathematics
>       |
> >|   mailto: ningerso@d.umn.edu   |   University of Minnesota-Duluth
>       |
> >|   http://umn.edu/~ningerso     |   http://www.d.umn.edu
>       |
> >-------------------------------------------------------------------
> --------
> >
>
> --
> Kevin B. Hendricks
> Associate Professor of Operations and Information Technology
> Richard Ivey School of Business, University of Western Ontario
> London, Ontario  N6A-3K7  CANADA
> khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
