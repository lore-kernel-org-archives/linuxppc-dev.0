To: "OTAVIO ISAMU SUGENO" <otavio.sugeno@siemens.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: D-Cache and I-Cache in PPC 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 31 Oct 2002 12:21:42 -0300."
             <B7AC573479F05C438F232539B961A1686C4D99@CUR1006V.br002.siemens.net.br>
Date: Thu, 31 Oct 2002 23:03:37 +0100
Message-Id: <20021031220342.B11B510158@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <B7AC573479F05C438F232539B961A1686C4D99@CUR1006V.br002.siemens.net.br> you wrote:
>
>
> Can anyone tell me how D-Cache and I-Cache using PowerPC MPC860T is set
> in Linux?

Boith are switched on (usually).

> I am using ppcboot and when it is initializing I can see D-Cache and
> I-Cache infos.
> This configuration is enough to Linux recognize this settings?

Linux does not really care about the setting used in the firmware; it
turns on the caches itself.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"355/113 -- Not the famous irrational number PI,  but  an  incredible
simulation!"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
