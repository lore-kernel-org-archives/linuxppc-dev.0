To: deepesh@india.tejasnetworks.com
Cc: Ethan Benson <erbenson@alaska.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Question regarding UBOOT. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 19 Jul 2003 19:28:08 +0530."
             <Pine.LNX.4.21.0307191918350.12735-100000@deepesh.india.tejasnetworks.com>
Date: Sat, 19 Jul 2003 18:29:25 +0200
Message-Id: <20030719162930.E88E4C6D82@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <Pine.LNX.4.21.0307191918350.12735-100000@deepesh.india.tejasnetworks.com> you wrote:
>
>
>  I have an EP8260 board. I have the u-boot binary. The board comes with a
> boot loader(PlanetCore). I want to load u-boot into RAM and then start
> executing from there. Is this possible? I tried doing this, but the board
> goes for a reset.

If the bianry is all you have then the answer is no, it cannot be done.

If you knoiw exactly what you're doing  you  can  modify  the  U-Boot
source  code  to  behave  like  you  want  - but then you have to ask
yourself _why_ you would want to do that.

My $ 0.02: Install U-Boot. Forget the other bootloader.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If there are self-made purgatories, then we all have to live in them.
	-- Spock, "This Side of Paradise", stardate 3417.7

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
