Date: Tue, 12 Oct 1999 00:26:14 -0400
From: Eric Dorland <dorland@lords.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Elliot Lee <sopwith@redhat.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: esound for PPC
Message-ID: <19991012002614.B526@HSE-MTL-ppp4363.qc.sympatico.ca>
References: <19991011231039.A526@HSE-MTL-ppp4363.qc.sympatico.ca> <Pine.LNX.4.10.9910112018260.15511-100000@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.9910112018260.15511-100000@opus.bloom.county>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 11, 1999 at 08:20:26PM -0700, Tom Rini wrote:
> On Mon, 11 Oct 1999, Eric Dorland wrote:
> 
> > On Mon, Oct 11, 1999 at 01:09:12PM -0700, Tom Rini wrote:
> > > 
> > > On Mon, 11 Oct 1999, Eric Dorland wrote:
> > > 
> > > > It appears I spoke to soon about sound working perfectly. Whenever esd plays
> > > > a 16bit wav file, the sound plays at about half speed. Ugg. At least its not
> > > > static anymore. I'm going to see if I can track down why this is happening
> > > > (maybe its some on-the-fly endianess swaping slowing it down), but I don't
> > > > know sound code all that well, so anyone that does, please lend a hand.
> > > 
> > > Elliot has the old set of patches ported up to 0.2.15, and hopefully will
> > > be in 0.2.16 :)
> > 
> > Which old set of patches? I've tried Elliot's 0.2.15 and it doesn't fix 
> > the playing of 16bit sounds. BTW, you need a patch to be able to compile 
> > Elliot's 0.2.15. It seems the configure file assumes that a ppc linux is 
> > MkLinux, and uses its driver instead of OSS. It appears its MkLinux that has 
> > the little-endian sound driver, not linuxppc. Anyway the attached patch 
> > changes removes the MkLinux testing (I don't know how to tell the
> > difference), and just uses OSS.
> 
> The patches which exist in a copy of 0.2.14, hence any working esound.
> They did not make it into 0.2.15, but will hopefully be in 0.2.16.  It
> does tell from MkL & Linux/PPC, and it also makes everything work "ok"
> again.

Which copy of 0.2.14? Where is it? I'd love to try them out :)

-- 

Eric Dorland
dorland@lords.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
