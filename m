Date: Thu, 12 Oct 2000 22:08:09 +0200 (MET DST)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmac_power_off is gone in 2.2.17
In-Reply-To: <20001012175322.A5273@suse.de>
Message-ID: <Pine.GSO.4.10.10010122007360.3519-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> the pmac_power_off() call in pmac_halt() disappeared in 2.2.17.
> Is there any special reason for that? I affects proably only B&W
> machines, /sbin/halt doesnt work anymore.

Did you try "halt -p"?

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
