Date: Tue, 30 May 2000 12:34:34 -0400 (EDT)
From: "Mark S. Mathews" <mark@absoval.com>
To: Dan Malek <dan@netx4.com>
cc: Matthew Locke <mlocke@jps.net>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: rpx_cfg() copy to NVRAM?
In-Reply-To: <3933EAF2.B966B675@embeddededge.com>
Message-ID: <Pine.LNX.3.96.1000530123136.8139B-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks Dan,  I'm using ffffff89, don't think that last bit matters much
since SW is turned off anyway.
;-)

BTW: I'll send the mods to head.S and embed_config.c later today, once I'm
sure they work.

Thanks,
-Mark

On Tue, 30 May 2000, Dan Malek wrote:

> Matthew Locke wrote:
>
> > SYPCR needs to be set to turn the watchdog off. Can't remember the value and
> > I don't have the docs in front of me.
>
> 0xffffff88
>
>
>
> 	-- Dan
>


Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.absoval.com
P.O. Box 941149            e-mail: mark@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
