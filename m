Message-Id: <v04003a21b6e9a03a5dae@[24.70.162.12]>
In-Reply-To: <3AC3ECE5.1B65198F@rochcivictheatre.org>
References: <20010329021803.Postino-029218@smtp01.highway.ne.jp>	
 <3AC2352D.384B57CA@rochcivictheatre.org>	
 <20010329222953.Postino-006016@smtp01.highway.ne.jp>	
 <3AC33CA7.E5DF4C03@vnet.ibm.com>
 <20010330062000.Postino-000633@smtp01.highway.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 29 Mar 2001 20:36:11 -0600
To: Tom Gall <gall@rochcivictheatre.org>,
	Kaoru Fukui <k_fukui@highway.ne.jp>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: Success kernel-243pre8-SMP(patch)(Re: spin_lock problem in
 recent   kernel
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 8:18 PM -0600 3/29/2001, Tom Gall wrote:
>  So assuming that CONFIG_SMP is on, this patch shouldn't yeild anything
>different what so ever from a codegen perspective with or without the
>patch for an SMP kernel build. It doesn't make sense.
>
>Kaoru Fukui wrote:
[...]
>> +#ifndef CONFIG_SMP
>>         spin_lock(&init_mm.page_table_lock);
>> +#endif

That's #if*n*def, not #ifdef. :)

And speaking of #ifndef, why are these spinlocks here in the first place
and/or why do they now need to be removed? Just suddenly removing locks
because of a new deadlock condition gets my spidey senses tingling.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
