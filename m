To: Ron Bianco <ronb@lcsaudio.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC7410 doesn't work with linux-2.4.20-denx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 15 Aug 2003 11:00:41 PDT."
             <000301c36357$240d93c0$4d00a8c0@warp-speed>
Date: Fri, 15 Aug 2003 21:21:18 +0200
Message-Id: <20030815192123.A359AC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000301c36357$240d93c0$4d00a8c0@warp-speed> you wrote:
>
> I'm curious as to what an MPC8260 is doing on a board based on an MPC7410?
> Is this a dual processor board?

I guess the CPU core of the 8260 is disabled, and they use it as  I/O
processor only. It provides a lot of nice communication features ...

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Pain is a thing of the mind.  The mind can be controlled.
	-- Spock, "Operation -- Annihilate!" stardate 3287.2

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
