Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 731F2DDE38
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 23:43:45 +1000 (EST)
In-Reply-To: <BE8C03AC-BA36-4A65-AFC6-A548E04A0359@kernel.crashing.org>
References: <1180996188.9632.68.camel@ld0161-tx32>
	<1182461025.21421.48.camel@ld0161-tx32>
	<BE8C03AC-BA36-4A65-AFC6-A548E04A0359@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <09602423-F30E-4C35-96EE-2B781AEF628B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 0/9] Add Generic PCI-E support to 8641HPCN
Date: Fri, 22 Jun 2007 08:44:29 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 21, 2007, at 5:29 PM, Kumar Gala wrote:

>
> On Jun 21, 2007, at 4:23 PM, Jon Loeliger wrote:
>
>> On Mon, 2007-06-04 at 17:29, Jon Loeliger wrote:
>>> Paul,
>>>
>>> This 8-part patch set combines the two previous patch
>>> sets, 5 from Zheng Wei, and 3 from me, along with one
>>> from Wade Farnsworth into one nice-n-happy set, all
>>> designed to re-enable PCI-Express on the MPC8641HPCN board.
>>>
>>> This is version 2 of the patch set and incorporates
>>> improvements suggested by list reviewers.
>>
>>
>> Paul,
>>
>> I hadn't seen any further comment on this series of
>> patches for PCI on 8641.  Any chance we could get them
>> applied to your repo?
>
> I've got a "cleaner" version of the float bus patch that I need to
> post and will apply the others to my tree.

I've posted a RFC for a change to pci indirect that should address  
our float bus problem.

http://ozlabs.org/pipermail/linuxppc-dev/2007-June/038263.html

- k
