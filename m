Message-ID: <3B8A8E16.B26A9254@mvista.com>
Date: Mon, 27 Aug 2001 14:14:46 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ralph Blach <rcblach@raleigh.ibm.com>
Cc: Linix PPC Emmbedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: support for only 255 processes on a 405
References: <3B8A3145.8F73BDA2@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:
>
> Is there any support for having a special case for the 405 that would
> limit the number of processes to 255.  This means that the pid and
> context could be the same.  This might be a performance gain.

The PID and context are already reused until there are more than 255
(or whatever the MMU can support) active processes.  There isn't a
special case needed, this is generic to all PowerPC with small context
space resources.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
