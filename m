Date: Fri, 19 Nov 1999 22:20:58 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Eric Dorland <dorland@lords.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Floppy problems
In-Reply-To: <19991119205819.A676@HSE-MTL-ppp4368.qc.sympatico.ca>
Message-ID: <Pine.LNX.3.96L.991119222014.8832A-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 19 Nov 1999, Eric Dorland wrote:
> 
> There seems to be a problem with the SWIM3 controller on my PowerMac G3.
> Whenever I try to do any floppy realted operation (mount, dd, whatever) it
> gives me this error:
> 
> end_request: I/O error, dev 02:00 (floppy), sector 36
> 
> does anyone know what this means or has had similar problems?
> 
> I'm running R5 on a a kernel I compiled myself, but not with anything
> outrageous, just a few patches. I've got a G3/266, and I'm running linux off
> a internal scsi drive.

Are you *positive* your floppy's good? Have you tried others?

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
