Date: Mon, 27 Sep 1999 09:05:51 +0200 (MET DST)
From: Geert Uytterhoeven <geert@sonycom.com>
To: minyard@acm.org
cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-user@lists.linuxppc.org,
        yellowdog-general@lists.yellowdoglinux.com,
        linuxppc-dev@lists.linuxppc.org, mklinux-setup@public.lists.apple.com
Subject: Re: XFree86-3.3.5-1.6.0b
In-Reply-To: <m2u2oh77bj.fsf@morse.concentric.net>
Message-ID: <Pine.GSO.4.10.9909270905180.11511-100000@begonia.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 26 Sep 1999 minyard@acm.org wrote:
> It's not working on my Lombard in 24-bit mode.  15-bit mode works
> fine.  Specifically, the server says:
> 
>    No valid modes found
> 
> at startup when 24bpp is specified.  It doesn't say why it is not
> valid, it just doesn't work.  Since it works in 15bpp mode, that seems
> rather odd.
> 
> Also, starting the screen saver causes the following:
> 
>   Fatal server error:
>   fbdevUpdateColormap: FBIOPUTCMAP failed (Function not implemented)
> 
> That would be nice to have fixed.  This did the same thing for 3.3.3.

You need to use a frame buffer device that's specific for your hardware, not
just offb.

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248648 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
