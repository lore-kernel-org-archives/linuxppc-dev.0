From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	<paulus@linuxcare.com.au>
Subject: Re: sym53c875 in 2.4.2
Date: Wed, 7 Mar 2001 16:27:13 +0100
Message-Id: <20010307152713.29411@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.05.10103071330410.773-100000@callisto.of.borg>
References: <Pine.LNX.4.05.10103071330410.773-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Are there any conflicting assignements ? Could you check if the new
>> phys_to_bus() function returns proper values (finds the bus on which
>> the Sym chip resides) ?
>
>My hose resources were not set up, so phys_to_bus() returned NULL.
Wouldn't it
>be better to return pa in that case, or at least print an error to the
>console?

Right, I'll look into this. Could you, on your side, figure out why they
weren't
setup properly ? The hose resource code is new (Paulus), I didn't yet dive in
it's gory details and it works fine on pmacs.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
