Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8FC13DE009
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 03:53:37 +1000 (EST)
Message-ID: <470A6E9C.50904@am.sony.com>
Date: Mon, 08 Oct 2007 10:53:32 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Ranulf Doswell <ralf@ranulf.net>
Subject: Re: [patch 2/6] PS3: Remove unused os-area params
References: <20071006213542.311447584@am.sony.com>	
	<20071006213542.595771597@am.sony.com>
	<18a15270710080700m514b49f6p7dc9cf6c8f80d6a6@mail.gmail.com>
In-Reply-To: <18a15270710080700m514b49f6p7dc9cf6c8f80d6a6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ranulf Doswell wrote:
> On 06/10/2007, *geoffrey.levand@am.sony.com
> <mailto:geoffrey.levand@am.sony.com>* <geoffrey.levand@am.sony.com
> <mailto:geoffrey.levand@am.sony.com>> wrote:
> 
>> struct saved_params {
>>-	/* param 0 */
>> 	s64 rtc_diff;
>> 	unsigned int av_multi_out;
>>-	unsigned int ctrl_button;
>>-	/* param 1 */
>>-	u8 static_ip_addr[4];
>>-	u8 network_mask[4];
> 
>>-	u8 default_gateway[4];
>>-	/* param 2 */
>>-	u8 dns_primary[4];
>>-	u8 dns_secondary[4];
>> } static saved_params;
> 
> As these values are correctly populated by the hypervisor from the
> preferences on the standard PS3 OS, it is incredibly useful to have this
> information available.


No, it is not used, and I never used it.


> Whilst none of the current 'popular' distributions use these fields, I
> am currently in the process of making a bootable CD image that does use
> them in order to initialise the network. Not having this information
> available means that the only sensible option is to use DHCP, which may
> well not be available in every case.
> 
> Please can we have these fields back? They don't actually take up all
> that much room, yet they are incredibly useful.


As a general rule we don't put unused code into the kernel, and I have no
plan to provide the support you mention.  Please submit a patch to the ML
with your feature for review.

-Geoff
