Message-ID: <3B78DCB6.8090504@humboldt.co.uk>
Date: Tue, 14 Aug 2001 09:09:26 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: bhupinder sahran <bhup_sah@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: running configuring cycle across the host side of a 21554 non transparent bridge
References: <20010814015521.7396.qmail@web3803.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


bhupinder sahran wrote:
> i am having a 21554 pci bridge between two processors.
> on the local side of the bridge MPC8240(linux) is
> sitting.
> from the local side i want to run configuration cycle
> of the host(primary) side of bridge.
> i am using semaphore method given by intel
> documentation.
> i have enabled the configuration up bit also.
> i am always getting 0xffffffff in my upstream config
> data register.
> can anybody tell me what could be the problem
> thanx in advance

As this is the third time you've asked, I'd say it's pretty likely that
nobody here knows the answer. I've used the 21554, but I've never
actually needed to do this.

--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
