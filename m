Subject: Re: diff between radeonfb.c and aty/radeon_base.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cedric Pradalier <cedric.pradalier@inrialpes.fr>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040512135950.4e6180ae.cedric.pradalier@inrialpes.fr>
References: <20040512135950.4e6180ae.cedric.pradalier@inrialpes.fr>
Content-Type: text/plain
Message-Id: <1084422549.13731.86.camel@gaston>
Mime-Version: 1.0
Date: Thu, 13 May 2004 14:29:09 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Note the ordering difference between ifdef and surface_cntl=0.
>
> Is this normal ? As far as i can see, this means that surface_cntl is
> not initialized on ibook with radeonfb.

iBooks have __BIG_ENDIAN set ;)

> I'll try to change and report.

The yellowish tint is an XFree bug afaik, are you using the DRI snapshots ?
They have a fix.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
