Message-Id: <v04003a02b6ed59f245ee@[24.70.162.12]>
In-Reply-To: <20010401220756.11222@smtp.wanadoo.fr>
References: <v04003a01b6ed50bf1d86@[24.70.162.12]>
 <v04003a01b6ed50bf1d86@[24.70.162.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 1 Apr 2001 17:24:03 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: Fwd: CPU features
Cc: <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 5:07 PM -0500 4/1/2001, Benjamin Herrenschmidt wrote:
>>not fully up-to-date, I'll check that asap.
>>
>>Ok, that crash appears to be fixed now.
>>
>>Now after arch:exit, it just... stops. Cmd-power doesn't bring up xmon, so
>>I have no idea where it's died.
>>
>>The sti replacement code still looked kinda weird, but I have no idea what
>>it's supposed to look like, so I guess that's ok...
>
>I'll have to look at this more closely. The problem may come from the
>spinlock problem (my fix might not be enough) or from another issue
>with my devel kernel as some of the new things in there have not yet
>been fully tested, especially on SMP.

I just booted with the second CPU wedged (that is to say, bootx from MacOS
9) with the same kernel to see what it would do with only 1 cpu, and it
still stops at the same place, so I'm guessing the problem should be
reproducable on a single-cpu system running an SMP kernel, if that helps
any.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
