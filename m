Subject: Re: Changes to "The plan"
To: akuster@dslextreme.com
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFA1123D85.667B22FB-ON85256C06.004182DD@raleigh.ibm.com >
From: "Ralph Blach" <rcblach@us.ibm.com>
Date: Tue, 30 Jul 2002 08:02:42 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Armin

It has always been my contention the the 4xx should be organized in the
following structure
Core
Chip
board

This would tree would then reflect the reallity of chip design methodology.
the 405 now has many variants
so it would be
405 Core
   Chip
      405CR
      405GP
      Board
                 Walnut
                  .
                  .
                  .
      NPE405L
       .
       .
       .


Chip


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
