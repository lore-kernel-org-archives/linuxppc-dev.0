Message-ID: <3B9E4B88.2090402@mvista.com>
Date: Tue, 11 Sep 2001 10:36:08 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Stefan Roese <stefan.roese@esd-electronics.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: AW: CPCI-405 port (PPC405GP)
References: <EFEAIMDCOOOHIEPHDNFJMEFHDCAA.stefan.roese@esd-electronics.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefan Roese wrote:

>>> Please find attached a port to our CPCI-405 board
>>
>> Nice job, but did you actually get your system booted?  There is
>> something generically wrong with the 405 port, and it's been a pain
>> in the ass trying to find it.  If you actually booted a system
>> that ran properly, it would be interesting to know what you used for
>> a file system.
>
>
> I get my system booted up to the busybox prompt via nfs root file system.
> After this most commands do nothing at all (as described from andrew may
> "405GP booting"), and the system hangs pretty soon :-(.
>
> I would think that the walnut port is behaving this way too, am I right?
>
  no, I pulled this morning and the walnut works fine.  I am using nfs
root with HHL2.0 userland.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
