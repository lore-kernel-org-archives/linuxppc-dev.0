Message-ID: <3B8A8FEC.172413E5@raleigh.ibm.com>
Date: Mon, 27 Aug 2001 14:22:36 -0400
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>,
	Linix PPC Emmbedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: support for only 255 processes on a 405
References: <3B8A3145.8F73BDA2@raleigh.ibm.com> <3B8A8E16.B26A9254@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan

Perhaps i dont understand.  It looks like from the code that process id
and pids dont match.  Could you explain how this code works.

Chip

Dan Malek wrote:
>
> Ralph Blach wrote:
> >
> > Is there any support for having a special case for the 405 that would
> > limit the number of processes to 255.  This means that the pid and
> > context could be the same.  This might be a performance gain.
>
> The PID and context are already reused until there are more than 255
> (or whatever the MMU can support) active processes.  There isn't a
> special case needed, this is generic to all PowerPC with small context
> space resources.
>
>         -- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
