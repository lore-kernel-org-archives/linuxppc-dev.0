To: brendan.simon@bigpond.com
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc-embedded: mpc8260 bus frequency calculations 
In-Reply-To: Message from Brendan J Simon <brendan.simon@bigpond.com>
   of "Fri, 02 Mar 2001 15:32:29 +1100." <3A9F225D.7040807@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain
Date: Fri, 02 Mar 2001 16:27:44 +1100
Message-ID: <14223.983510864@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 02 Mar 2001 15:32:29 +1100, Brendan J Simon <brendan.simon@bigpond.com> writes:
>I would like to see the board_info structure members be interpreted as
>Hz rather than MHz.

If you used ppcboot, you could enable the CFG_CLKS_IN_HZ config option and
then ppcboot would do exactly what you want.

>... I'm wondering if I will
>break anything if I change the meaning to Hz.

I run my 2.4.1+ 8260 kernel with the board info clocks supplied in HZ and
everything appears to run fine. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
