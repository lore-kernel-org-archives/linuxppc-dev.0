Message-ID: <3D4760C7.7070001@dslextreme.com>
Date: Tue, 30 Jul 2002 21:00:07 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Ralph Blach <rcblach@us.ibm.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Changes to "The plan"
References: <OFA1123D85.667B22FB-ON85256C06.004182DD@raleigh.ibm.com > <20020731013958.GI27711@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:
> On Tue, Jul 30, 2002 at 08:02:42AM -0400, Ralph Blach wrote:
>
>>Armin
>>
>>It has always been my contention the the 4xx should be organized in the
>>following structure
>>Core
>>Chip
>>board
>>
>>This would tree would then reflect the reallity of chip design methodology.
>>the 405 now has many variants
>>so it would be
>>405 Core
>>   Chip
>>      405CR
>>      405GP
>>      Board
>>                 Walnut
>>                  .
>>                  .
>>                  .
>>      NPE405L
>>       .
>>       .
>>       .
>>
>
> It's not clear to me what you're proposing.  Are you talking about the
> layout of the Config.in options, the layout of the .c files in various
> directories or the call structure of the platform initialization code?
>
>

Well, the lastest 2.5 model working after having some local discusions is:

board files are in /platforms/4xx such as walnut.*, ebony.*

implimentation files are in /kernel/4xx such as ibm405gp.*, ibm44gp.*,
ppc4xx_* & ppc405_*, I guess head should go there too.

the core files like ibm4xx, ibm405.h & ibm440.h are in include/asm-ppc
as well as ibm_ocp.h

Things like ocp.c and ocp_proc will most likely end up in drivers/ocp
since ocp can support more than just ppc.

comments
armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
