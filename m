Subject: Re: ncurses problem in telnet/serial console.
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: Omanakuttan <omanakuttan@tataelxsi.co.in>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3F0ACE50.90908@tataelxsi.co.in>
References: <3F0ACE50.90908@tataelxsi.co.in>
Content-Type: text/plain; charset=ISO-8859-1
Date: 08 Jul 2003 21:14:48 +0200
Message-Id: <1057691688.3430.269.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2003-07-08 at 15:59, Omanakuttan wrote:
> [root@pandatel12 ~]#
> When we telnet to the port 23, the error we get it
>
> [root@pandatel12 ~]# telnet 10.1.28.44
> Trying 10.1.28.44...
> Connected to 10.1.28.44 (10.1.28.44).
> Escape character is '^]'.
> Error opening terminal: vt100.
> Connection closed by foreign host.
> [root@pandatel12 ~]#

You do not have support for vt100 can it be more obvious.

Start your program with

"TERM=kljdf /bin/mdi"

and see what happens.

--
Ericsson AB                       Tel: +46 8 719 70 20
Tellusborgsvägen  90              Fax: +46 8 719 29 45
126 25 Stockholm                  ken@switchboard.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
