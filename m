Mime-Version: 1.0
Message-Id: <v04210100b501ab3a304d@[212.6.77.33]>
In-Reply-To: <200003242210.OAA16878@ shell1.ncal.verio.com>
References: <200003242210.OAA16878@ shell1.ncal.verio.com>
Date: Sat, 25 Mar 2000 01:08:15 +0100
To: "Henry A. Worth" <haworth@ncal.verio.com>
From: <cesli@ewetel.net>
Subject: Re: OF compatible serial PCMCIA cards?
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 14:10 -0800 on 2000-03-24, Henry A. Worth suggested:


>Does anyone know of any PCMCIA serial I/O cards that
>would be compatible with OF for use as the OF and/or
>XMON/Linux consoles? This would be for the PB2000.
>
>I ran across a site a with links to PCMCIA cards with
>Mac support.  It had a link to www.socketcom.com, which
>a local store stocks, but the socketcom site did not
>have word-one about Mac support. Their serial cards are

IMHO Mac support does include a Mac driver sitting in your extensions
folder, so far not really interesting.
you went through OF ?
via:
0> dev /aliases
0> .properties
0> words
0> devaliases
after that step I can see on my 3400:
.
.
.
lower	/bandit/ti1130@13
upper	/bandit/ti1130@13,1
.
.
ata2	/bandit/ti1130@13
ata3	/bandit/ti1130@13,1
[the ata2/3 alias works good for MacOS booting from my 2.5" pcmcia
enclosure HD; did not try it with Linux, 'cause I did not manage to
mount it from my Linuxbox with the pcmcia-cs ide_cs.o and ide.conf,
and therefore could not install Linux partitions on that HD]

0> dev /bandit/ti1130@13
0> .properties			[tells you something about this port]
0> words				[output gives a hint about
port-capabilities]

don't know what your input/output defaults are [type 'printenv']
but if I remember correctly you can change it for example with
0> "lower" input

HTH
Claus


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
