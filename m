From: Benjamin Herrenschmidt <bh40@calva.net>
To: David Edelsohn <dje@watson.ibm.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: rtc again... 
Date: Fri, 4 Aug 2000 17:50:23 +0200
Message-Id: <20000804155023.5420@mailhost.mipsys.com>
In-Reply-To: <200008041525.LAA30014@mal-ach.watson.ibm.com>
References: <200008041525.LAA30014@mal-ach.watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>	On RS/6000 CHRP (RS/6000 Platform Architecture), RTAS provides
>freeze-time-base and thaw-time-base calls which signal all of the
>processors inan SMP complex to stop and start the TB.  I do not know of
>any functionality within the PowerPC architecture which would allow
>processors to coordinate their TBs without some external intervention.
>
>	Normally AIX boot freezes the TB, zeroes the TB on each processor,
>and then starts the timebase synchronized.  Because the functionality is
>part of RTAS, this can be done at any time.  I do not know what PreP SMP
>systems do and I know that Apple discourages use of RTAS because it is not
>intended to work.

On recent Core99 machines, Apple has a HW timer in the KeyLargo ASIC that
can be used to sync timebases. (It looks like a 64 bits bus-cycle timer,
but I'm not completely sure yet). There's also, I beleive, the OpenPIC timer.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
