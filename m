To: "OTAVIO ISAMU SUGENO" <otavio.sugeno@siemens.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: CPU performance measurement 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 22 Jul 2002 08:01:37 -0300."
             <B7AC573479F05C438F232539B961A1686C4CF0@CUR1006V.br002.siemens.net.br>
Date: Mon, 22 Jul 2002 19:27:16 +0200
Message-Id: <20020722172721.8D8AD10874@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <B7AC573479F05C438F232539B961A1686C4CF0@CUR1006V.br002.siemens.net.br> you wrote:
>
> I would like to measure the cpu performance in my custom board.
> Basically to know how many of cpu performance each process or driver is
> spending, something like TOP command in PCs.
>
> Anyone has already this experience or can give me suggestion?

Why don't you simply run "top" on your board, then?

Or read /proc/stat?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Put your Nose to the Grindstone!
                 -- Amalgamated Plastic Surgeons and Toolmakers, Ltd.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
