Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "'Matt Porter'" <mporter@kernel.crashing.org>,
	"'Wolfgang Grandegger'" <wolfgang.grandegger@bluewin.ch>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 405 TLB miss reduction
Date: Mon, 15 Dec 2003 12:26:39 +0100
Message-ID: <002401c3c2fe$4f494730$0a01a8c0@LUMENTIS02>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <20031211104505.C26110@home.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > > I've also been thinking about dynamically using large
> TLB/PTE mappings
> > > for ioremap on 405/440.
> >
> > OK, I expect not so much benefit from this measure but it
> depends on the
> > application, of course.
>
> Yes, I've seen a lot of apps with huge shared memory areas across PCI
> that can benefit from this...they used BATs on classic PPCs.

hmm, I wonder if this would be useful for systems using JFFS2/MTD?
JFFS2/MTD usually ioremaps the underlying FLASH memory, which can be
many MB.

 Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
