Message-ID: <3AE05D07.E216DC0E@mvista.com>
Date: Fri, 20 Apr 2001 12:00:07 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: zjuzhou@163.net
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Which file tell chip selecting in source,Hard Hat for RPXlite?
References: <3ADFEAD3.10027@bjapp4>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


zjuzhou@163.net wrote:

>         i can't find file which file tell me the chip select in hard har linux source.i use MPC850,Hard Hat for RPXlite borad.

The chip selects are not determined by Linux, they are configured
by the boot rom.  Check the manufacturer documentation for this
information.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
