Subject: Re: X engine over Video Controller
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Rupesh S <rupeshs@myw.ltindia.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <004c01c331d2$0975bcb0$6706a8c0@SPLENDOR>
References: <Pine.LNX.4.44.0306121603120.1349-100000@ike>
	 <004c01c331d2$0975bcb0$6706a8c0@SPLENDOR>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1055689938.1863.187.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Date: 15 Jun 2003 17:12:18 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-06-13 at 19:34, Rupesh S wrote:
>
> I work with FADS823 board running PPC-Linux.
> Now that I plan to put a X-Engine over my Video Controller inbuilt in MPC823
> and supported by FADS board.
> Need help in selecting the X-Engine and the feasibility of the same with the
> above mentioned board.
> Also I would like to know if I can get any ind of reference for the same....

By 'X engine' do you mean an X server? If so, the easiest way might be
to get a framebuffer device going and use an X server on top of that.


--
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
