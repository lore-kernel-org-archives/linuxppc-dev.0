Date: Tue, 16 Apr 2002 13:32:20 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
To: Stefan Berndtsson <stefan@nocrew.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: R128 Scaling.
Message-Id: <20020416133220.782c956e.adrian@humboldt.co.uk>
In-Reply-To: <878z7nuamf.fsf@hades.nocrew.org>
References: <878z7nuamf.fsf@hades.nocrew.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 16 Apr 2002 13:49:12 +0200
Stefan Berndtsson <stefan@nocrew.org> wrote:

> What is the status of the scaling registers for rage128? I saw a patch
> in the archive, that adds scaling capabilities for the framebuffer,
> and that seems to work reasonably well.

I started looking at that a while ago, but didn't get very far. To get
much further (and also to tackle the VGA out problems) I probably need
the chip docs, but I haven't really pursued them. My one email asking to
become an X developer was ignored, and I don't know of any other way to
get the docs currently.

The scaling patches I worked on had a problem with display flickering.
They also needed a general mechanism to get the physical panel size.

> When running something in DGA (xmame for example), with XF4.1 and UseFBDev,
> the resolution is changed by MAME, but it seems it still gets the fullsize
> resolution passed to it, because it draws completely distorted graphics.
> The area indicates that 1024x768 is passed as resolution even though the
> display is set to 640x480 using scaling.

I didn't get this one resolved at the time.


--
Adrian Cox
http://www.humboldt.co.uk/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
