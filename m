Return-Path: <David.Daney@caviumnetworks.com>
Received: from mail3.caviumnetworks.com (mail3.caviumnetworks.com
	[12.108.191.235]) by ozlabs.org (Postfix) with ESMTP id 9C6441007D2
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 09:22:38 +1000 (EST)
Message-ID: <4C2A8038.50204@caviumnetworks.com>
Date: Tue, 29 Jun 2010 16:22:32 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 4/9] Add Synopsys DesignWare HS USB OTG Controller driver.
References: <12778468223309-git-send-email-fchen@apm.com>
	<12778468233898-git-send-email-fchen@apm.com>
	<12778468231438-git-send-email-fchen@apm.com>
	<1277846824673-git-send-email-fchen@apm.com>
	<20100629231302.7E6E314EBF8@gemini.denx.de>
In-Reply-To: <20100629231302.7E6E314EBF8@gemini.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>, gregkh@suse.de,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/29/2010 04:13 PM, Wolfgang Denk wrote:
> Dear Fushen Chen,
>
> In message<1277846824673-git-send-email-fchen@apm.com>  you wrote:
>> Implements DWC OTG USB Host Controller Driver (HCD) and interface to
>> USB Host controller Driver framework.
>>
>> Signed-off-by: Fushen Chen<fchen@apm.com>
>> Signed-off-by: Mark Miesfeld<mmiesfeld@apm.com>
>> ---
>>   drivers/usb/otg/dwc_otg_hcd.c | 2397 +++++++++++++++++++++++++++++++++++++++++
>>   drivers/usb/otg/dwc_otg_hcd.h |  421 ++++++++
>>   2 files changed, 2818 insertions(+), 0 deletions(-)
>>   create mode 100644 drivers/usb/otg/dwc_otg_hcd.c
>>   create mode 100644 drivers/usb/otg/dwc_otg_hcd.h
>
>
> Why are you posting this old driver version without trying to sync
> against our tree which includes a number of fixes - you should know
> about these.
>

This could be a question with an obvious answer, but which tree are you 
referring to when you say 'our tree'?

David Daney
