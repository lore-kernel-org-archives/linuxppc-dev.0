Message-ID: <3A553DEB.7E966DE4@mvista.com>
Date: Thu, 04 Jan 2001 22:22:19 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: frowand@mvista.com
CC: "'Matthias Fuchs'" <matthias.fuchs@esd-electronics.com>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 4MB initrd crashes linux on 405 hardhat linux
References: <B25E2E5A003CD311B61E00902778AF2A018279E0@server1.skystream.com> <3A553C09.2AB9F6F@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Frank Rowand wrote:


> This fix is also not in the FSM Labs linux_2_5 tree.  I will eventually
> submit it into the proper tree if no one beats me to it.

The reason it is not in the source tree is because this isn't the
reason for the failure.  Applying this patch simply causes the
real bug not to be seen.  The real problem was the way the initrd
and other kernel resources were initialized, which has been fixed
long ago.

There are lots of PowerPC systems using initrd as large as 24 Mbytes
without trouble.  I suspect this 405 tree isn't up to date in other
generic places, which is why you still see this problem.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
