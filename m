To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: TFTP not able to find file??? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 02 Feb 2003 14:28:27 PST."
             <995FF289C9D69747A09E42992644595405B23643@penguin.adic.com>
Date: Sun, 02 Feb 2003 23:59:12 +0100
Message-Id: <20030202225917.AB348C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <995FF289C9D69747A09E42992644595405B23643@penguin.adic.com> you wrote:
>
> That was it. Thanks. I needed that sym link "ln -s . tftpboot" to get it to
> work. Thanks a million.

Note that this is just a workaround, not a fix.

> Wolfgang Denk:
>
> Might want to make a note to add that clip to section 3.2 "Configuration of
> a TFTP Server" to the "PPCBoot and Embedded Linux Guide" as I don't recall
> seeing it there.

I don't intend to document workarounds for broken configurations.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Q:  Do you know what the death rate around here is?
A:  One per person.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
