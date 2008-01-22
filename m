Return-Path: <joshua.williams@qlogic.com>
Received: from EPEXCH1.qlogic.org (eppat.qlogic.com [198.186.5.11])
	by ozlabs.org (Postfix) with ESMTP id F359BDDF1E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 06:13:45 +1100 (EST)
Message-ID: <479640BB.8020704@qlogic.com>
Date: Tue, 22 Jan 2008 13:15:07 -0600
From: Joshua Williams <joshua.williams@qlogic.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Various new ibm405 DCRN #defines
References: <47952018.7050702@qlogic.com>	<1200956274.6807.12.camel@pasglop>	<47962316.8040709@qlogic.com>
	<20080122111038.1072dac4@weaponx>
In-Reply-To: <20080122111038.1072dac4@weaponx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Tue, 22 Jan 2008 11:08:38 -0600
> Joshua Williams <joshua.williams@qlogic.com> wrote:
> 
>> Benjamin Herrenschmidt wrote:
>>> On Mon, 2008-01-21 at 16:43 -0600, Joshua Williams wrote:
>>>> Various new ibm405 DCRN #defines.
>>>>
>>>>      Signed-off-by: Joshua Williams <joshua.williams@qlogic.com>
>>> May I ask what for ? :-) Also, it's all arch/ppc, not arch/powerpc...
>>> nothing we want to improve to much on at this stage unless there's a
>>> really good reason.
>> The 405x #defines were incomplete and this was meant to
>> make them a bit tighter.  Since arch/ppc is in life support
>> mode this can wait until the 405x stuff gets moved over to
>> arch/powerpc.
> 
> Which 405x stuff?  Walnut is moved over already.  Other boards will
> need to be ported by people that have those boards.

Gotcha.  I'll revisit this once everything has been moved over.

- Josh
