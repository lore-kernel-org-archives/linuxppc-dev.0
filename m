Date: Wed, 20 Oct 1999 10:23:53 -0400 (EDT)
From: "Mark S. Mathews" <mark@absoval.com>
To: Jim Lewis <jlewis@mvista.com>
cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA use
In-Reply-To: <380DCA0D.B272F889@mvista.com>
Message-ID: <Pine.LNX.3.96.991020102219.5531D-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



pcmcia-cs hasn't been ported to the 8xx yet.  Adding the 8xx pcmcia setup
code necessary to initialize a slot and bring up a specific card isn't
that hard.  I've done it on other platform...just not Linux yet.

-Mark 

On Wed, 20 Oct 1999, Jim Lewis wrote:

> 
> Hello,
> 
> Has anyone out there done anything with PCMCIA on the 8xx?
> 
> Thanks,
> 
> --
> Jim Lewis
> Sr. Field Applications Engineer
> MontaVista Software, Inc.
> (817)261-9088 http://www.mvista.com
> 
> 


Mark S. Mathews

AbsoluteValue Software     Web:    http://www.absoval.com
P.O. Box 941149            e-mail: mark@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
