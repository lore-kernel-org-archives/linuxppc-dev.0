Message-ID: <3BEFFBCF.7010600@embeddededge.com>
Date: Mon, 12 Nov 2001 11:41:51 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Sarnath Kannan <sparc64@rediffmail.com>
Cc: ashish anand <ashisha@india.infogain.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: "OpenPIC versus EPIC" in MPC8240 !
References: <20011112084114.25202.qmail@mailFA3.rediffmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sarnath Kannan wrote:

> Hi Ashish,
>   what I felt was, populating reserved areas
> is a bug.

It's only a bug if we don't know we are doing this and
it is causing problems.  We know we can do what we
are doing without trouble.  I'm not trying to
justify this hack or claim it is the proper solution.
It just happens to work, allows us to take advantage of
existing software functions, and someday it may be changed.

When someone like you shows up and your only concern or
contribution is to fix this function, then do it.  I don't
want to hear why you think someone else did it wrong or what
someone else should do to make it better.  Just fix the damn
thing!  When someone like me is trying to do hundreds of things
to get a board port done, using any existing code is exactly
what I'm going to do.  For EPIC I could take advantage of a
bunch of existing code instead of discussing why it should
change, or rewriting and testing on a whole bunch of other platforms
that doesn't help me make progress.  If you have the time to
rewirte and test it on _everything_ affected, go right ahead.


> I has said that this could be a __possible__
> cause for getting bogus interrupts. I would
> say there is 80% possibility.

You are just digging a deeper hole.  Bugs are either 100% there
or not there at all.  There isn't an 80% possibility of a bug.......
The _conditions_ under which a bug can appear are variable,
but a bug is a bug.

>  Moreover if u can read the EPIC manual,
> u can notice that IVPR and SVPR both start
> at  offset 0x50200. ( So the IVPR space is
> not a continous 24 entries. It is actually
> overalapped and discontinous )

If you actually _understood_ what you read, you would notice
this register space has different functions depending upon
the configuration of the EPIC and the design of the hardware
surrounding it.  You will also notice that because of the way
we initialize and utilize the openpic and interrupt management
functions that we properly configure the interrupt source registers
for the board design.

>   I have no idea of hurting people. But if a bug
> is pointed out, there is no harm in accepting it.

More importanly, you should do something constructive and fix it.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
