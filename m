To: Magnus Damm <damm@opensource.se>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA Modem/Serial Cards and MPC8xx? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 26 Aug 2003 13:14:40 +0200."
             <20030826131440.031012f5.damm@opensource.se>
Date: Wed, 27 Aug 2003 12:38:28 +0200
Message-Id: <20030827103833.7B999C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030826131440.031012f5.damm@opensource.se> you wrote:
>
> I don't know how things are today, but there was a collision between
> the mpc8xx-uart code and the standard "pc" uart-code once upon a time.

Correct.

> I think the mpc8xx-uart code used the same struct as the other uart code,
> but overloaded some values... But that was Linux-2.2.x, things have
> probably changed - I hope... =)

Not in the official trees, I'm afraid.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
War is never imperative.
	-- McCoy, "Balance of Terror", stardate 1709.2

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
