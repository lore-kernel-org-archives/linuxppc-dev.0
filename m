From: "Stefano Coluccini" <s.coluccini@caen.it>
To: "=?iso-8859-1?B?U+liYXN0aWVuIEP0dOk=?=" <scote1@matrox.com>
Cc: "Dan Malek" <dan@mvista.com>,
	"Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: KERNELBASE at 0xa0000000
Date: Mon, 26 Feb 2001 17:48:04 +0100
Message-ID: <NDBBIFIMCKPOADMAJOKMEEGNCPAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20010226110745.A1229@dyn-52-73.matrox.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> On 2001.02.26 10:51:57 -0500 Stefano Coluccini wrote:
> > I have hoped it was more platform-dependent because I have a MVME5100
> > (that
> > is, I think, a MCPN765 with a PCI-VME bridge) and with KERNELBASE at
> > 0xa0000000 doesn't work (in head.S the kernel doesn't recognize that it
> > is
> > running at 0 and it try to relocate itself).
> > Do you think that this is a warning of a more complicated problem ?
>
> I think that's what happened when I changed KERNELBASE but not
> KERNELLOAD.
> Try changing both (if it's not already done).

I have leaved both untouched the first time, then I have changed both to
0xc0000000 to get working.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
