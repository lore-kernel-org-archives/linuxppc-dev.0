Message-ID: <3ECE343B.8040702@embeddededge.com>
Date: Fri, 23 May 2003 10:46:19 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: John Ma <kwma@avantwave.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: slow in user space?
References: <3ECDD7C0.80401@avantwave.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John Ma wrote:

>    I have a MPC8241 board and  running ppc kernel 2.4.21-pre7 on it.


> ....But after the root filesystem is mounted and
> /sbin/init is started, the system becomes very slow.  I need to wait
> several minutes for the login console.

Your DUART interrupts aren't routed/initialized correctly.  The serial
driver has timeouts that slowly poll the driver if interrupts aren't
showing up.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
