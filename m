Date: Sat, 26 Aug 2000 18:34:41 +0200 (MET DST)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Dan Malek <dan@embeddededge.com>
cc: Ronald Wahl <rwa@peppercon.de>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: allocating uncachable memory
In-Reply-To: <39A6AF42.323B88C@embeddededge.com>
Message-ID: <Pine.GSO.4.10.10008261825550.25785-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> There isn't anything generic right now.  A few of us are working on
> a solution, as there are other processors affected (IBM 4xx) as well.

IMO the only portable solution would be a memremap (similiar to ioremap).

> Don't forget that managing the caches in software (via flushes and
> invalidates) could actually provide better performance for data
> transfers due to the cache bursting available when caches are enabled.

Sure? Often you don't want io data in the cache at all. io is mostly slow
and you have to wait anyway. On the other hand such stuff is also a horror
to debug.

bye, Roman.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
