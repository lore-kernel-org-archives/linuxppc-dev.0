Message-ID: <3D46C36F.9000302@embeddededge.com>
Date: Tue, 30 Jul 2002 12:48:47 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Ralph Blach <rcblach@us.ibm.com>
Cc: akuster@dslextreme.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Changes to "The plan"
References: <OFA1123D85.667B22FB-ON85256C06.004182DD@raleigh.ibm.com >
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:

> It has always been my contention the the 4xx should be organized in the
> following structure

I know, and like I have said in the past that doesn't fit into the rest
of the PowerPC strucuture very well.  We have processor parts and we have
boards (or platforms), that we can mix and match in a variety of ways.
There are other board vendors that want the exact opposite, since they
have a single board that can have a variety of different processors.
We currently separate the processors from the boards, so either of the
views will work.  The configuration scripts determine how we "view"
the underlying structure.  Currently, you select a processor type, and
then we provide a board selection to go with that, which is exactly
what you are asking for.


> This would tree would then reflect the reallity of chip design methodology.

The reality of chip design is they are becoming more integrated, things that
used to be on a board are now on a chip.  Logically no different to a
system configurator.  Our current configuration method simply asks for a
board type to reduce the number of configuration questions to be answered.
We could just as easily have a configurator that asks lots of questions
about the peripherals that need to be supported, and the underlying
directory structure wouldn't have to change.


> the 405 now has many variants

Doesn't matter to us, we can deal with that today.  There are lots
of variants of other PowerPC chips as well, and we found ways to
make them look _less_ different, requiring fewer configuration options
and a less complex directory structure.  You may want to consider
doing the same.  Please don't confuse the marketing enjoyment of
lots of variants with the software necessary to support them.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
