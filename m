Message-ID: <3FB416F9.7080303@jonmasters.org>
Date: Thu, 13 Nov 2003 23:42:49 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: [Fwd: ppc4xx Ports]
Content-Type: multipart/mixed;
 boundary="------------060504040009010306090402"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------060504040009010306090402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi there,

Thanks to Matt Porter for suggesting I might care to try here.

Cheers,

Jon.

--------------060504040009010306090402
Content-Type: message/rfc822;
 name="ppc4xx Ports"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc4xx Ports"

Message-ID: <3FB411A6.9030608@jonmasters.org>
Date: Thu, 13 Nov 2003 23:20:06 +0000
From: Jon Masters <jonathan@jonmasters.org>
Organization: World Organi[sz]ation Of Broken Dreams
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ppc4xx Ports
X-Enigmail-Version: 0.81.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi there,

I am working on a 405D port using a base kernel of originally 2.4.20 and
now 2.4.21 from kernel.org rather than Montavista etc.

There are several 4xx ports kicking around and each bodges the tlb stuff
in pgtable.h and elsewhere makes simple fixes to make the stock kernel
actually work...though there are several different offerings by now.
Would someone care to share experiences privately about 4xx ports?

Cheers,

Jon.

P.S. The stock 2.4.21 kernel on has a bunch of very trivial bugs (from
losing a register in the syscall handler to breaking shared ptes) and
will not compile correctly out of the box so to speak. A lot of people
seem to be using the Montavista tree as a result. Now rather than
whining I would also like to help so am asking to make contact with
whoever co-ordinates merging these trees together etc.


--------------060504040009010306090402--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
