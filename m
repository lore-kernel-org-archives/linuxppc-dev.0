Message-ID: <3E820D3B.4030803@embeddededge.com>
Date: Wed, 26 Mar 2003 15:27:39 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Dmitriy.Zavin@infineon.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCC2 and SCC3 serial ports on RPX Classic (MPC860)
References: <FD90897E35ABD311AE0E0008C7E6404A07192EDE@ca02exch4.sjc.infineon.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dmitriy.Zavin@infineon.com wrote:

> Any ideas??

My first guess would be some clock routing for the baud rate
generators isn't configured correctly.  There are some driver
assumptions about which clocks/paths are associated with
each port.  They could be used by something else, or the
driver configuration may not have selected the proper ones.

My second guess would be to check the logic external to the
860.  Ensure the external drivers are enabled and that any
data paths through asics are properly routed.  IMHO, this
shouldn't be part of the uart driver due to the number
of possible configurations.

good luck.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
