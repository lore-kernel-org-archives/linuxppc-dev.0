To: "Stephen Williams" <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel hangs in early_init 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 02 Mar 2004 10:48:42 PST."
             <4522-80798@sneakemail.com>
Date: Wed, 03 Mar 2004 00:56:27 +0100
Message-Id: <20040302235632.341E4C0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <4522-80798@sneakemail.com> you wrote:
>
> Good point, I missed that. However, that particular FAQ doesn't seem
> to apply. I'm using 2.4.24+ (>2.4.5), the CFG_IMMR value doesn't seem
> to apply (PPC405GPr, not a MPC8xx system) and I double-checked that
> the bd_t structure matches. Besides, it's nowhere neer trying to access
> any of the arguments yet.

I think it does access arguments. Linux  will  need  parameters  like
clock frequencies, memory sizes etc. Passing wrong paramteters is one
of the most frequent causes of that particular failure mode.

> The stack at the time is still where U-Boot left it, near the end of
> the 128Meg memory. Is this something I should address (pardon the pun)?

I don't think so.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If a man had a child who'd gone  anti-social,  killed  perhaps,  he'd
still tend to protect that child.
	-- McCoy, "The Ultimate Computer", stardate 4731.3

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
