To: "rick.liu" <dovi@eyou.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kermit:How to disable the flow control signals? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "18 May 2003 12:59:03 +0800."
             <20030518125903.28066.qmail@eyou.com>
Date: Sun, 18 May 2003 12:21:55 +0200
Message-Id: <20030518102200.B44FBC6162@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

in message <20030518125903.28066.qmail@eyou.com> you wrote:
>
> >Ummm... why do you bother? Is anything not working?
>
> Yes,my console still outputs nothing,even not a single word.

Maybe your target does not output  anything  (at  least  not  at  the
expected baudrate) ?

> So,I must first make sure it's not my console emulator's problem.

Test with a known to work device first.

> So there is no money for something like BDI.

You pay anyway - either with money for the BDI,  or  with  your  time
when you try to do without it.

> As u mentioned before,I will read u-boot source,maybe it's a way of continue
> my
> work.Would u give me a clue of uboot,I mean the sequence of boot and the
> according
> source file?I didnot find this kind of infomation on the internet.

Booting starts at the reset vector, i. e. at _start in cpu/*/start.S

But this is off topic here. Follow-up to u-boot-users, please.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
One does not thank logic.
	-- Sarek, "Journey to Babel", stardate 3842.4

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
