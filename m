MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Problems running PING, Telnet 
Date: Tue, 5 Feb 2002 18:07:15 -0500
Message-ID: <FF6CF34C346E724596A2FB5CAAB2C4978842CF@voyager.ops.infiniswitch.com>
From: "Wright, David" <dwright@infiniswitch.com>
To: "murali nagarajan" <muralin@gdatech.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: murali nagarajan [mailto:muralin@gdatech.com]
> Sent: Tuesday, February 05, 2002 5:03 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Problems running PING, Telnet
> We have the following difficulties:
>                                    ----------
> - PING command does not work
>   The erro message I get is   "ping: unknown protocol icmp"
>
> - Telnet program does not work which tells me that the
> service is unknown.
>    The error message I get is "telnet: tcp/telnet: unknown service"
>
> What can be the issue?

Sounds as though your system lacks /etc/services and /etc/protocols
files, so the socket opens are failing.

  -- David Wright, InfiniSwitch Corp.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
