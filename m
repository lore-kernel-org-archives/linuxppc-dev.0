MIME-Version: 1.0
Subject: RE: CPU performance measurement 
Date: Mon, 22 Jul 2002 15:30:34 -0300
Message-ID: <B7AC573479F05C438F232539B961A168095005@CUR1006V.br002.siemens.net.br>
From: "OTAVIO ISAMU SUGENO" <otavio.sugeno@siemens.com.br>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: segunda-feira, 22 de julho de 2002 14:27
To: OTAVIO ISAMU SUGENO
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: CPU performance measurement

In message
<B7AC573479F05C438F232539B961A1686C4CF0@CUR1006V.br002.siemens.net.br>
you wrote:
>
> I would like to measure the cpu performance in my custom board.
> Basically to know how many of cpu performance each process or driver
is
> spending, something like TOP command in PCs.
>
> Anyone has already this experience or can give me suggestion?

>>Why don't you simply run "top" on your board, then?
I tried to run "top" on my custom board, but no success. No message
appears on console. Do I need to do anything special, any configuration?

>>Or read /proc/stat?
I will try this. What kind of information can get from /proc/stat? Is it
any kind of statistics?

Thanks
Otavio Sugeno

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
