Message-ID: <3CFEEDEA.6040605@embeddededge.com>
Date: Thu, 06 Jun 2002 01:06:50 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: Do we need tlbsx at finish_tlb_load?
References: <20020530080434.GY16537@zax>	<20020603024344.GA6765@zax>	<3CFC0794.7020907@embeddededge.com>	<15612.47115.300768.766742@argo.ozlabs.ibm.com>	<3CFCFDB0.9010304@embeddededge.com> <15614.49971.298608.61998@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:

> However, in the context of 4xx, if we load an entry into the TLB with
> the valid bit clear, all that will happen is that the cpu will give us
> the same TLB miss exception again immediately.

Yes, I remember now....thanks for reminding me.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
