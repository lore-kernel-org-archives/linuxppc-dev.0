From: "T.Michael Turney" <tmike@mvista.com>
To: "Mark Pilon" <mpilon@midrivers.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: how to enable core files ?
Date: Tue, 26 Feb 2002 13:06:03 -0800
Message-ID: <NEBBKCGFALCNLJBOFHKIIEHMCPAA.tmike@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3C7BF0F5.A830D984@midrivers.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In your .bashrc file

	ulimit -c unlimited

allows a core file of unlimited size to be created.

ulimit is a bash built-in, so if you want additional
info do a man bash and search for ulimit.
Cheers,
T.mike

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Mark
> Pilon
> Sent: Tuesday, February 26, 2002 12:33 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: how to enable core files ?
>
>
>
> That is, what do I have to set / enable / include on my target
> so that a core file will be created when an application SEGVs ?
>
> I'm running Wolfgang's SELF -- and really need to be able to poke
> at a core file when my app dies.
>
> thanks,
>
> Mark
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
