Message-Id: <m12ukmg-001SyaC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Re: Floating Point problems with Linux on the EST SBC8260
To: linuxppc-embedded@lists.linuxppc.org
Date: Wed, 24 May 2000 19:41:54 -0400 (EDT)
Cc: all@cideas.com
In-Reply-To: <392C4A4B.2839C790@embeddededge.com> from "Dan Malek" at May 24, 2000 05:31:55 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>From Dan Malek:

> Further, you would have discovered the 1.1 CDK is for an 8xx and the
> libraries are compiled for soft (in-line) floating point.  You are
> mixing floating point instructions with library and compiler support
> that assumes otherwise.

My application was statically linked against the Denx CDK that was
compiled for hard float.  The static application already has all the
libraries routines that it needs, hence it won't pull in the Hard Hat
Linux 1.1 libraries (soft float) from the root filesystem.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
