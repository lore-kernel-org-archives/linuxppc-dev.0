Message-Id: <v04003a02b709cb418690@[24.70.162.12]>
In-Reply-To: <851yqkhrje.fsf@junk.nocrew.org>
References: <20010420171327.26883@mailhost.mipsys.com>
 <85itjzilbx.fsf@junk.nocrew.org>
 <20010420171327.26883@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 23 Apr 2001 07:18:01 -0500
To: Lars Brinkhoff <lars.spam@nocrew.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: Bogus interrupt -1
Cc: <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 4:52 AM -0500 4/23/2001, Lars Brinkhoff wrote:
>Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>> >At first, the first six or so messages appeared, but everything seemed
>> >fine.  Later, the last messages appeared, and it seemed like one of
>> >the two processors in my 2001 Dual G4 had wedged.  According to "top",
>> >there was always at least 50% idle time.
>> Did you enable distribution of IRQs to all CPUs ?
>> I don't think it's completely safe yet.
>
>Yes, IRQ distribution was enabled.  I disabled it, and now the
>messages don't appear any more.  However, it still seems like one CPU
>hangs after some time.

A friend of mine is having trouble with one CPU hanging in his dual G4
under MacOS X. You may want to check to make sure you don't have a hardware
problem.

The symptoms are pretty much (from what he's told me): The system runs for
a while, then one of the CPUs goes off into la-la land never to return
again. Not very complicated.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
