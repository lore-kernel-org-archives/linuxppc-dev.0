To: Ron Bianco <ronb@lcsaudio.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Kernel choices for 824x with ext3 FS 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 21 Oct 2003 12:47:27 PDT."
             <000101c3980c$2811a3a0$4d00a8c0@warp-speed>
Date: Tue, 21 Oct 2003 22:10:37 +0200
Message-Id: <20031021201042.534DAC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Ron,

in message <000101c3980c$2811a3a0$4d00a8c0@warp-speed> you wrote:
>
> I've been looking at Denx's 2.4.4 port, linuxppc 2.5, linux 2.4.22 and the
> latest 2.6.0-test trees.

You can also use our linuxppc_2_4_devel tree from CVS (version 2.4.20)

> BTW, many thanks to Wolfgang Denk for making available the ELDK and his ( and
> others ) embedded PPC specific work!

You are welcome :-)

> Unfortunately we can't use 2.4.4 as ext3 FS support is not present.
> FYI, we may also have a need to use RTAI.

We use our linuxppc_2_4_devel tree to validate the PowerPC port of RTAI.

> It is desirable to use the most up to date, yet robust for ppc, kernel possible
> and this is somewhat awkward timing vis a vis the status of the 2.6.0 kernel.
> But most pertinent ppc related patches seem to be included in 2.6.0 now along
> with other enhancements, such as reduced latency, that are not present in
> 2.4.22.   So it is a bit of a quandary for me, and perhaps for others as well.

I think our 2.4.20 tree is pretty stable; this is one reason we don't
support more recent versions yet.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Nothing ever becomes real until it is experienced.       - John Keats

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
