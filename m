Message-Id: <200110091859.f99IxRf30086@ashley.ivey.uwo.ca>
Date: Tue, 9 Oct 2001 14:56:29 -0400
From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Content-Type: text/plain;
	format=flowed;
	charset=us-ascii
Subject: Re: overnight 2.4.11 seems to have used up all memory, slow as a dog
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
To: Dan Malek <dan@mvista.com>
In-Reply-To: <3BC33C1C.5802F78B@mvista.com>
Mime-Version: 1.0 (Apple Message framework v388)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Once that fix makes it into Ben's tree, please let me know and I would
be happy to repeat that experiment to see if the problem is fixed.

Thanks,

Kevin


ps:

A download of official 2.4.10 with Alan's ac10 patch applied (cleanly)
seems to be missing a lot of agp pieces (drivers/char/agp/agpgart_be.c)
and has a bug (parse error) in drivers/char/pc_keyb.c in line 400 when
compared to Ben's tree.  Is this to be expected?

Thanks,

Kevin



On Tuesday, October 9, 2001, at 02:04 PM, Dan Malek wrote:

> Benjamin Herrenschmidt wrote:
>
>> There was at least one VM bug fixed between pre4 and pre5,
>
> I just saw David Miller post another one on the Sparc Linux vger
> tree.  We will have to track it down and see if it affects us.
>
>
> 	-- Dan
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
