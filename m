Date: Wed, 26 Apr 2000 00:30:26 -0700
From: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
Subject: Re: Dual head on a Powerbook
To: FASSINO Jean-Philippe <jeanphilippe.fassino@rd.francetelecom.fr>
Cc: LinuxPPC <linuxppc-dev@lists.linuxppc.org>
Message-id: <39069B12.52B2B005@dana.ucc.nau.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <3906199F.1D7F995@dana.ucc.nau.edu>
 <390690B1.1194EC88@rd.francetelecom.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


FASSINO Jean-Philippe wrote:

> Tim Wojtulewicz wrote:
>
> > I'm trying to connect a projector to the monitor port on the back of my
> > powerbook, so I can do a presentation with it.  Anyone have any
> > information on dual headed support on powerbooks?  Pismo, LinuxPPC2000,
> > 2.2.15pre19
>
> I'm doing this using Xpmac and booting with BootX.
> First configure external display to be primary in MacOS (be
> careful with depth color !).
> Next, start Linux which display on external monitor.
> This method work only with Xpmac and not with FBDev (3.3.x).

I tried this just now and it didn't work.  In MacOS, I have the monitor set
to 1024x768 at thousands of colors.  Both monitors display the same image.
When I boot back to Linux, something flashes on the external monitor.  It
says something about OF, but it disappears to fast for me to read it fully.
Then the image disappears, and nothing else appears on the external monitor.
I am using the latest (rev 9) Xpmac.

Tim


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
