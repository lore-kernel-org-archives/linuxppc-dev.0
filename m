Message-ID: <3B4CAB59.DA517FDC@mvista.com>
Date: Wed, 11 Jul 2001 15:39:05 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: jonathan.hurley@ni.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Booting HHL on Motorola Sandpoint X3 (with MPC 8245)
References: <OFF9D2B304.538379E0-ON86256A86.006B0650@natinst.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


jonathan.hurley@ni.com wrote:

> .... I believe there have been some minor changes in the
> main board design between the X2 and X3,

Ummm...if you look through the archives you will notice this has
been discussed.  They are more than "minor" changes, mostly due to
the use of the serial interface to the EPIC.

> ...  Does HHL currently support the Sandpoint X3 system, and if not are
> there any future plans to add support for the new platform?

HHL would support the X3 if you purchased a subscription and
specifically asked for that.  I have the patches, they just won't
work with the latest 2_4_devel tree and they aren't suitable as
a generic addition.  When I get the current tree to work properly
for 4xx/8xx again, I'll make the updates for both the 7450 and the X3.
I either have to convince the OpenPIC maintainers this is a good
addition (which I don't even think it is) or find an alternative.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
