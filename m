Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 01DBBDDEC7
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 05:14:43 +1000 (EST)
Message-ID: <4717B09B.3060800@pobox.com>
Date: Thu, 18 Oct 2007 15:14:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 0/4] FEC - fast ethernet controller for mpc52xx
References: <20071014075511.GC3000@nd47.coderock.org>	
	<4713BA1C.2050604@pobox.com>
	<fa686aa40710180715u23d81adfy83ff65837725fb80@mail.gmail.com>
In-Reply-To: <fa686aa40710180715u23d81adfy83ff65837725fb80@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Domen Puncer <domen.puncer@telargo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 10/15/07, Jeff Garzik <jgarzik@pobox.com> wrote:
>> Domen Puncer wrote:
>>> Hello!
>>>
>>> If there are no objections, I would like to get this merged
>>> when bestcomm goes in (any time now?).
>>>
>>> It's split into four parts:
>>> 1 - device tree
>>> 2 - small bestcomm change
>>> 3 - the actual driver
>>> 4 - phy part of the driver
>> patches #3 and #4 need to be combined together.
>>
>> Are the arch people OK with patches #1 and #2?
> 
> Jeff,
> 
> The bestcomm patches and patch 1 & 2 from this series are now in
> Linus' tree.  That clears the way for the FEC driver when Domen
> reposts it.  (In other words; there is nothing left in arch land
> blocking this driver)
> 

except a resend combining patches 3 and 4 as requested :)
