Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: <gopi@india.tejasnetworks.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: mpc 8260 performance..
Date: Fri, 31 Jan 2003 07:37:30 -0800
Message-ID: <NCBBIINEHIPFGJPLBEIFKEKKEBAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <Pine.LNX.4.21.0301311456080.22077-100000@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> In this case, the system can potentially be interrupted too
> often(assuming an interrupt per frame received and transmitted,
> it comes to nearly interrupt every few 10s of uSecs).  So, though the
> packet processing doesnt take much time(involving movement of skbs
> and modifying few fields), there is a hidden cost of context
> swaps(kernel isr, bh, user space)
>
> I am not sure of the effect of this on performance..

Sounds like a HW design issue you need to address. Perhaps it would be
better to interrupt on buffer full or some sort of data ready but timeout
condition. It is good to be concerned about IRQ but this does not affect CPM
performance...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
