Subject: RE: bitkeeper
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: fred@sc23.sc.mcel.mot.com
Cc: Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <003901c27427$2f861c60$940879c8@sc.mcel.mot.com>
References: <003901c27427$2f861c60$940879c8@sc.mcel.mot.com>
Content-Type: text/plain
Date: 15 Oct 2002 11:47:31 +0200
Message-Id: <1034675251.15944.33.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2002-10-15 at 10:45, fred wrote:
>
> I am behind firewall. I can use neither rsync nor bk. I miss tar.bz2 packet.

BK works over http also and can be used with a http proxy.

export http_proxy=http://proxy:80

Do not forget the port number BK do not try on port 80 by default as a
lot of other programs do.



--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
