Date: Sun, 20 Jul 2003 15:54:59 +0000
From: Giuliano Pochini <pochini@shiny.it>
To: Calum Selkirk <cselkirk@xs4all.nl>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Radeon problems
Message-Id: <20030720155459.0d3b1fc0.pochini@shiny.it>
In-Reply-To: <20030719162022.GB2427@xs4all.nl>
References: <20030719145532.20ff05e3.pochini@shiny.it>
	<20030719162022.GB2427@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 19 Jul 2003 18:20:22 +0200
"Calum Selkirk" <cselkirk@xs4all.nl> wrote:

> video=radeonfb:1280x854-8@60

I tried several resolutions without success. It seems that parameter is
completely ignored. I'll try to figure out the problem. I fixed the same
bug some years ago in the controlfb.

> > Problem #2: I've managed only to use X in fbdev mode at 16bits. No way
> > to use the radeon driver.  Any hint ?
>
> no idea about YD, nor the configuration of your kernel, nor your
> XF86Config, but 24bit should be possible.

I installed the latest X 4.3.99 and it works fine. I didn't notice that v4.2.0
don't support the radeon9000...


--
Bye.
   Giuliano.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
