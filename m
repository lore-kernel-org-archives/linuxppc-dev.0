From: phandel@cise.ufl.edu
Date: Sat, 30 Oct 1999 14:36:33 -0400 (EDT)
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linux-2.2.13pre15 stability w/ head.S patch
In-Reply-To: <381A6CF9.67FE83E2@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.9910301430550.4926-100000@PetesBox.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 30 Oct 1999, Martin Costabel wrote:

> compile. And then none of them boots. After the first few lines ("kernel
> xxx booting ...") they just sit there. No error message that would give
> any hint. 

I've gotten to this stage myself after quite a few patches (and the
realization that the PowerBook PMU must be defined!) just to stare at the
"Booting..." screen.  I've tried all sorts of combinations of BootX
versions, checking/unchecking the video driver, and double-checking
scsi/graphics settings, but am at a loss and will start playing with
start.c next.

I'd be happy to submit my patches, although I'm sure there's a "standard"
way of patching things that I don't yet know of (as I am a fairly new
kernel hacker), so I haven't.


Thanks,
Peter

-- 
Peter F. Handel          "[The anti-Christ] also forced everyone, small and
phandel@cise.ufl.edu      great ... to receive a mark [smart card?] on his
www.cise.ufl.edu/~phandel right hand or on his forehead, so that no one could
FAX: (561) 619-8051       buy or sell unless he had the mark"-Revelation13:16

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
