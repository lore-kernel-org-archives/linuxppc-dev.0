From: Benjamin Herrenschmidt <bh40@calva.net>
To: Wolfgang Haeuptli <whaeuptli@bluewin.ch>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Need testers with MESH SCSI
Date: Fri, 22 Dec 2000 18:18:03 +0100
Message-Id: <19341116104947.29047@192.168.1.2>
In-Reply-To: <00122217123800.00661@lobo.localnet>
References: <00122217123800.00661@lobo.localnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Well, would have been a nice christmas present... BUT STILL:
>(after applying the new mesh_init() to scsi/mesh.c)
>
>mesh: target 6 aborted
>
>which means that my UMAX Astra 1200S Scanner still does not work under
>linuxppc...

Can you try increasing the udelay() calls in mesh_init() to see if it
helps ? There maybe something else going on, but it's worth trying.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
