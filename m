Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DFA4FDDFE9
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 17:45:39 +1100 (EST)
Message-ID: <4762268C.1020305@garzik.org>
Date: Fri, 14 Dec 2007 01:45:32 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] ucc_geth: use rx-clock-name and tx-clock-name device
	tree properties
References: <11967166791607-git-send-email-timur@freescale.com>
	<1196716680381-git-send-email-timur@freescale.com>
	<1196716685975-git-send-email-timur@freescale.com>
	<4373ED4B-5EDD-4725-9D99-BE39B0656E19@kernel.crashing.org>
In-Reply-To: <4373ED4B-5EDD-4725-9D99-BE39B0656E19@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, Timur Tabi <timur@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Dec 3, 2007, at 3:17 PM, Timur Tabi wrote:
> 
>> Updates the ucc_geth device driver to check the new rx-clock-name and
>> tx-clock-name properties first.  If present, it uses the new function
>> qe_clock_source() to obtain the clock source.  Otherwise, it checks the
>> deprecated rx-clock and tx-clock properties.
>>
>> Update the device trees for 832x, 836x, and 8568 to contain the new 
>> property
>> names only.
>>
>> Signed-off-by: Timur Tabi <timur@freescale.com>
>> ---
>>
>> This patch applies to Kumar's for-2.6.25 branch.  ucc_geth will 
>> compile but not
>> run if my other patch, "qe: add function qe_clock_source" has not also 
>> been
>> applied.
> 
> Jeff, I'll take this patch via powerpc.git if you don't have any issue 
> since its just touching probe/setup bits.

ACK
