In-Reply-To: <1071962774.8935.23.camel@gaston>
References: <20031220175850.416fb0ec.colin@colino.net> <1071962774.8935.23.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v609)
Message-Id: <D65308DD-42F3-11D8-8972-000A95A4DC02@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Colin Leroy <colin@colino.net>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] tas3004_tables.c off-by-one
Date: Fri, 9 Jan 2004 23:33:24 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> I found out this was due to too short (by one item) arrays in
>> tas3004_tables.c. This patch fixes it. I just copied over the last
>> entry
>> of each array.
>
> Interesting, my understanding is that those values were taken
> from Darwin ;) I'll look at this too along with your fan stuff
> and merge, thanks.

It could be these tables are taken from Darwin, but there is no need
for that; the chip manual contains those tables, too (but for a bigger
range of values).


Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
