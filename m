Return-Path: <albert_herranz@yahoo.es>
Received: from smtp112.mail.ukl.yahoo.com (smtp112.mail.ukl.yahoo.com
	[77.238.184.50]) by ozlabs.org (Postfix) with SMTP id B77AD1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 02:42:35 +1100 (EST)
Message-ID: <4B0EA1E8.6070603@yahoo.es>
Date: Thu, 26 Nov 2009 16:42:32 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 16/19] powerpc: wii: hollywood interrupt controller
	support
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-16-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-17-git-send-email-albert_herranz@yahoo.es>
	<1259213022.16367.273.camel@pasglop>
In-Reply-To: <1259213022.16367.273.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Sun, 2009-11-22 at 23:01 +0100, Albert Herranz wrote:
> 
>> +static void hlwd_pic_mask_and_ack(unsigned int virq)
>> +{
>> +	int irq = virq_to_hw(virq);
>> +	void __iomem *io_base = get_irq_chip_data(virq);
>> +
>> +	clear_bit(irq, io_base + HW_BROADWAY_IMR);
>> +	set_bit(irq, io_base + HW_BROADWAY_ICR);
>> +}
> 
> Same comment as with flipper. BTW. It looks really similar, can't you
> use the same driver ?
> 

I'll look at it. Surely, parts of it would be mergeable.

> Cheers,
> Ben.
> 

Thanks,
Albert

> 
> 
