Subject: Re: VGA out on ibook2
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: =?ISO-8859-1?Q?F=E9lix?= Ortega <guile@mac.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <1003076294.11870.1.camel@milleniumfalcon>
References: <1003076294.11870.1.camel@milleniumfalcon>
Content-Type: text/plain; charset=ISO-8859-1
Date: 18 Oct 2001 03:02:32 +0200
Message-Id: <1003366952.32511.744.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2001-10-14 at 18:18, Félix Ortega wrote:
>
> En sáb, 2001-10-13 a 13:05, Michel Dänzer escribio:
> [...]
> > Do you use Option "UseFBDev" in X?
> Yes. I'm using Ati driver 16bit depth with the option UseFBDev,
> PanelWidth 1024 and PanelHeigth 768.
> The behaviour of the vga out it's a little strange. If I boot without
> the external monitor conected, when I turn on external monitor with
> m3mirror, I have the "wavy" image I described in the other message. But
> if I boot with the external monitor connected, from OpenFirmware I have
> external monitor and when I boot I have a cuasi-perfect text console and
> an X console like if it's on another depth. If I put the X Server at 8
> bit depth, I can see almost perfect picture (the colors are wrong). If I
> put 16 or 24 bit, I have a "dual" screen, the screen divided in planes
> so if I move the cursor across the middle of the screen, the cursor in
> the external monitor exits right and enter left. If I switch back to the
> text console, everything is ok.
> I have tried with Ati Xfree and with FrameBuffer X, with the same
> results.

Sounds like an aty128fb bug then.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
