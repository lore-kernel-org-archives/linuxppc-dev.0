Date: Thu, 8 Feb 2001 16:48:39 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Roman Zippel <zippel@fh-brandenburg.de>
Cc: David Edelsohn <dje@watson.ibm.com>, paulus@linuxcare.com.au,
	Dan Malek <dan@mvista.com>, Gabriel Paubert <paubert@iram.es>,
	tom_gall@vnet.ibm.com, linuxppc-commit@hq.fsmlabs.com,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
Message-ID: <20010208164839.K27838@hq.fsmlabs.com>
References: <200102082114.QAA25048@mal-ach.watson.ibm.com> <Pine.GSO.4.10.10102082250080.24436-100000@zeus.fh-brandenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.10.10102082250080.24436-100000@zeus.fh-brandenburg.de>; from Roman Zippel on Fri, Feb 09, 2001 at 12:23:48AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


} The page table abstraction is only used for user space vm management. The
} important point is: it's only an abstraction as far as it concerns the
} general vm code. What happens underneath is a complete different story and
} the general code should provide enough hooks to allow the implementation
} to do whatever it wishes. If something is missing it can certainly be
} added, but always remember not to mix abstraction with implementation.
}
} Anyway, an idea to improve current context handling: define another bit
} _PAGE_HASHED for the pte. If it's set, it points to the hash table entry,
} otherwise it's a normal linux pte entry. That makes pte handling a bit
} more complicated, but if we can dump the current tlb/context handling, it
} should be really worth it.

I disagree.  I think the overhead would slow it down quite a bit.  That
being said, implement it and prove me wrong.  I'll merge it in.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
