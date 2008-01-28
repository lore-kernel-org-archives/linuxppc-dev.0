Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id E88C2DDDFB
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 02:26:46 +1100 (EST)
Message-ID: <479DF432.3000506@windriver.com>
Date: Mon, 28 Jan 2008 10:26:42 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/9] qe/muram dts: Explicitly set address-cells and size
	cells for muram
References: <1201505279-25847-1-git-send-email-paul.gortmaker@windriver.com>
	<a050480a21aef92854805e9bee517c0d65d5bd59.1201503958.git.paul.gortmaker@windriver.com>
	<Pine.LNX.4.64.0801280903130.19922@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0801280903130.19922@blarg.am.freescale.net>
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

Kumar Gala wrote:
> On Mon, 28 Jan 2008, Paul Gortmaker wrote:
>
>   
>> Currently there are several dts that don't specify address or size
>> cells for the muram.  This causes dtc to use default values, one of
>> which is an address-cells of two, and this breaks the parsing of the
>> muram ranges, which is assuming an address-cells of one. For example:
>>
>> Warning (reg_format): "reg" property in
>> /qe@e0100000/muram@10000/data-only@0 has invalid length
>> (8 bytes) (#address-cells == 2, #size-cells == 1)
>>
>> Explicitly setting the address and size cells gets it parsed properly
>> and gets rid of the four dtc warnings.
>>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> ---
>>  arch/powerpc/boot/dts/mpc836x_mds.dts |    4 +++-
>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>
>>     
>
> Also fixed up mpc832x_*.dts and mpc8568mds.dts.
>   

Thanks - I'd done those as well but forgot to git-add....

P.
