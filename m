Date: Thu, 12 Oct 2000 23:24:58 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmac_power_off is gone in 2.2.17
Message-ID: <20001012232458.A31574@suse.de>
Reply-To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
References: <20001012175322.A5273@suse.de> <Pine.GSO.4.10.10010122007360.3519-100000@zeus.fh-brandenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.10.10010122007360.3519-100000@zeus.fh-brandenburg.de>; from zippel@fh-brandenburg.de on Thu, Oct 12, 2000 at 10:08:09PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 12, Roman Zippel wrote:

>
> Hi,
>
> > the pmac_power_off() call in pmac_halt() disappeared in 2.2.17.
> > Is there any special reason for that? I affects proably only B&W
> > machines, /sbin/halt doesnt work anymore.
>
> Did you try "halt -p"?

That might work, but why can I poweroff any other machine with halt?
(ibook, wallstreet, 7200?)


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
