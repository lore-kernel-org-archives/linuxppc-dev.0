Message-ID: <39085B6D.CD5C811D@student.ethz.ch>
Date: Thu, 27 Apr 2000 17:23:25 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
CC: "W. Taylor Holliday" <wtholliday@ucdavis.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4.0 dual monitor on AGP G4
References: <Pine.LNX.4.21.0004271613030.8585-100000@idd-01.imbc.gr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kostas Gewrgiou wrote:

> > PS: I still think it should work with the r128 driver if it support the
> > "fbdev" option...
>
>  Yes it would work, there is a problem with the approach taken by
> fbdev/glint, the BusID info isn't used at all there for the choise
> of the device to be opened,

Really? The code seems to do it IMHO.

> without the fbdev option you always get /dev/fb0 which might not be what you
> want.

Almost certainly not (Ask Taylor ;)


> Here is a small patch (untested) that changes r128 to use the "fbdev"
> option instead of using BusID to get the fbdev device.

The patch you included in the later mail is reversed, so you have to use the
-R option to apply it.

Just a hint...


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
