To: Dan Malek <dan@netx4.com>
Cc: Pavel Roskin <pavel_roskin@geocities.com>,
        "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>,
        "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Software Emulation Exception...
References: <Pine.LNX.4.21.0004071011570.19406-100000@sunapee.transcept.com> <38EE0267.FB881499@embeddededge.com>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 10 Apr 2000 11:37:28 +0200
In-Reply-To: Dan Malek's message of "Fri, 07 Apr 2000 11:44:39 -0400"
Message-ID: <kfywvm6s3dz.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@netx4.com> writes:

> > > "Software Emulation %s/%d NIP: %lx *NIP: 0x%x code: %x"
>
> So, decode the address/instruction and see if it makes sense.
>
> > The problem has gone after upgrading to the Montavista kernel (from their
> > CDK 1.0)
>
> Since I know something about both of your custom board designs, I
> can say that the software is unlikely to be the trouble, although it
> could affect the problem.  This exception is typical of custom designs
> that haven't properly designed the external device interfaces to the
> 8xx bus.

Well, it also happens to be typical to the MM problem solved by
the patches at http://www.zeta.org.au/~linsol/ (which are included
in the Montavista kernel).

And by Pavel's description it's almost 100% certain that the MM
bug is the problem.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
