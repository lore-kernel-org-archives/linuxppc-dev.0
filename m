Message-ID: <3ACC1118.446211F0@mvista.com>
Date: Thu, 05 Apr 2001 02:30:48 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: jerry <jerry.nguyen@serialsystem.com.sg>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: how to get the physival address
References: <20010404155419.8B369281DB@denx.denx.de> <001001c0bd86$c54562a0$de0fa8c0@mystore> <3ACC0989.4BAA6CB9@mvista.com> <002001c0bd99$96c03a00$de0fa8c0@mystore>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


jerry wrote:

> But it does not work  for  defined variable (it was defined in driver so it
> should be in kernel space, isn't it?).

A loadable driver is dynamically allocated from kernel virtual memory.
The dynamic virtual memory does not have the 1:1 mapping property to
real memory that virt_to_phys(), __pa() or anything else expects.  To
me, based upon my past experience, you should be able to get this
mapping information for any virtual address, but others want to
argue about that point.  So, I have "fixed" the PowerPC verions of
these functions in the linuxppc_2_5 kernel, but who knows if it
will last.......


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
