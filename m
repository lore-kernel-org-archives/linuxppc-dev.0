To: Jeff Stevens <jsteve17@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SMC1 Uart Problems on 2.4.24-pre2 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 09 Feb 2004 08:36:52 PST."
             <20040209163652.94313.qmail@web41411.mail.yahoo.com>
Date: Mon, 09 Feb 2004 18:17:43 +0100
Message-Id: <20040209171748.C05E6C108D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040209163652.94313.qmail@web41411.mail.yahoo.com> you wrote:
> Thank you very much, that did it!

I know :-) This register dump in your crash dump was pretty obvious:

	...
	DAR: 000003F9 ...
	...

Guess who might try stepping on such an address...

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"...one of the main causes of the fall of the Roman Empire was  that,
lacking  zero,  they had no way to indicate successful termination of
their C programs."                                     - Robert Firth

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
