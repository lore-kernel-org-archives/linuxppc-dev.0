Message-ID: <385E817A.D2B76318@netx4.com>
Date: Mon, 20 Dec 1999 14:20:26 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>
CC: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Booting w/out BOOTP and still have IPv4 comeup.
References: <199912201808.NAA02902@hoover.gilbarco.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wohlgemuth, Jason wrote:

> Just a quick question.  I have linux going on an embedded MPC860.  The
> application that is running on it uses sockets but when I disable bootp all
> the socket calls fail since the network has not been configured properly.


I have only been able to do this by using 'ifconfig'.  I don't
know the details, but simply setting the IP address like this
doesn't seem to invoke some initialization functions.  Using
ifconfig after the system boots works just fine.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
