Message-ID: <3954DDFA.D1C60A7B@denise.shiny.it>
Date: Sat, 24 Jun 2000 12:12:42 -0400
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.16 and G3
References: <XFMail.000622101355.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I can't make Linux working on my G3. I suppose the problem is
> gfx-card related. Since there is no aty128 support I leave
> unchanged the same config I had on my old Mac (controlfb) and
> I boot with BootX and "no video...Idontremember" option set.
> It boots fine but it panics at the first "ls" or so :((

I discovered why it crashes... it's the buggy USB support.

Bye.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
