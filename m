MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: How to set connection timeout with sockets
Date: Tue, 20 May 2003 15:25:34 -0400
Message-ID: <3D296C067098F149B11A8F4FC37C0546553A57@EXVS1.ops.infiniswitch.com>
From: "Wright, David" <dwright@infiniswitch.com>
To: "IGOR LURI" <iluri@fagorautomation.es>,
	=?iso-8859-1?Q?EMBEDDED_LINUXPPC_=28Correo_electr=F3nico=29?= <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I am doing an aplication with STREAM sockets and
> I need to know how can I set or modify the timeout value of
> the connection and the paquets  sent.
>
> With function  setsocketoption  I am no t able to set it.
>
> If someone knows how can I do it, please send me the answer.

You can only set the TCP keepalive time via

  /proc/sys/net/ipv4/tcp_keepalive_time

but that affects every TCP socket on the system.  You'd also
need to set tcp_keepalive_intvl and tcp_keepalive_probes to
handle this completely.

  -- David Wright, InfiniSwitch Corp.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
