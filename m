Date: Fri, 1 Mar 2002 11:49:31 +0100 (CET)
From: Christian Pellegrin <chri@infis.univ.trieste.it>
To: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
Cc: "'Owen Green '" <owenjinggreen@yahoo.com>,
	"'linuxppc-embedded@lists.linuxppc.org '" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: gdbserver ppc8xx
In-Reply-To: <6B546A602AD2D211BFF00008C7A4288905844007@hrtades2.atea.be>
Message-ID: <Pine.LNX.4.44.0203011144100.11578-100000@sole.infis.univ.trieste.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> This did not work, I got the getprotobyname: Sucess,
> what means my /etc/protocols have the entry for tcp.
> Thanks anyway.
>

if you are ultra-lazy and like bad code just edit remote-utils.c and
hardocde protocol number for TCP .... shouldn't chage shortly I guess ;-).

NSS is a hassle with embedded systems since is far too general .... even
busybox bypasses it ;-)

Bye!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
