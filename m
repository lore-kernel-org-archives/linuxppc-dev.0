Subject: Re: Which XFree86 version has Flat Panel support in Radeon?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20011020005756.EKCA12483.tomts13-srv.bellnexxia.net@there>
References: <Pine.BSF.4.32.0110102251240.17602-300000@shell.unixbox.com>
	<20011020005756.EKCA12483.tomts13-srv.bellnexxia.net@there>
Content-Type: text/plain; charset=ISO-8859-1
Date: 20 Oct 2001 13:34:17 +0200
Message-Id: <1003577657.25062.176.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2001-10-20 at 03:00, Kevin B. Hendricks wrote:

> I just tried to use my Radeon with the FlatPanel with XFree86 4.1.0 but I
> could not get it to work.  I looked in
> xc/programs/Xserver/hw/xfree86/drivers/ati at radeon_driver.c and noticed
> lots of comments saying Flat Panel support was disabled.
>
> I did see ifdef ENABLE_FLAT_PANEL in places but it was clear that support
> was not included completely yet.
>
> I would very much like to use my flat panel display.  Can anyone tell me
> which Branch of the XFree86 tree I should go looking for Radeon Flat Panel
> support

Only the trunk is more current than the 4.1 branch.

> or who (which developer) at Xfree86 I should be e-mailing to get
> the bleeding edge so that I can start to work on this.

I think Alan Hourihane is the core team developer who has been working
on the radeon driver the most, but Ani might be a good place to start.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
