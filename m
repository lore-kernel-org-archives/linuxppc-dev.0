Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux on MPC5200 - LITE5200EVAL
From: Gerrit Van de Velde <gvd@denayer.wenk.be>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040211101500.E7339C1215@atlas.denx.de>
References: <20040211101500.E7339C1215@atlas.denx.de>
Content-Type: text/plain
Message-Id: <1076495328.4808.2.camel@nios>
Mime-Version: 1.0
Date: 11 Feb 2004 11:28:48 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I patched with sirdeff.patch and it works now, also great tip about the
handshaking, that saved me a day too I guess ;)

I'll rebuild with latest U-boot too.

Thanks Wolfgang & Peter & Andrew :)

On Wed, 2004-02-11 at 11:14, Wolfgang Denk wrote:
> In message <1076491141.4841.6.camel@nios> you wrote:
> >
> > I followed these instructions and it all worked out fine (left out the
> > examples directory of U boot though) , but after the reboot in lowboot
> > jumper configuration, i only see garbage on my minicom screen. I can
> > figure out some characters that look familiar (like the countdown for
> > the autostart) so I assume it's working correctly but doesn't get
> > displayed right. I also can't interrupt the countdown so input doesn't
> > work. Already tried to change the 115200 8N1 settings of the
> > communications (but why would they change anyway..) and didn't help.
>
> You are using the latest U-Boot (= top of CVS), aren't you?  If  not:
> try  it  out.  There  were  some  rounding  errors  in  the  baudrate
> calculation.
>
>
> Best regards,
>
> Wolfgang Denk
>
> --
> See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> "The question of whether a computer can think is no more  interesting
> than the question of whether a submarine can swim"
>                                                 - Edsgar W.  Dijkstra
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
