Message-ID: <3D403DC1.3070008@mvista.com>
Date: Thu, 25 Jul 2002 11:04:49 -0700
From: Todd Poynor <tpoynor@mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Cort Dougan <cort@fsmlabs.com>,
	Matthew Locke <mlocke@mvista.com>, akuster <akuster@dslextreme.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/Patch] 4xx idle loop
References: <20020725105336.F2276@host110.fsmlabs.com> <20020725162026.19919@192.168.4.1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> Also, in this specific case, we might well want to have an machine
> specific power saving feature: I've had various tweaks in mind for
> powermac laptops that I never ended up implementing...

This will also be true for the IBM 405LP (starting with the "Beech" eval
board), which has a number of new PM features (
http://www.research.ibm.com/arl/projects/papers/405LP.pdf ).  IBM has
internally used a pm_idle function pointer a la i386, hoping that would
be the community-accepted way, in case ya wanna add that to the
suggestion pile, but I think any of the methods proposed would be fine.


--
Todd


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
