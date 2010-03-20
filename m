Return-Path: <albert_herranz@yahoo.es>
Received: from smtp136.mail.ukl.yahoo.com (smtp136.mail.ukl.yahoo.com
	[77.238.184.67]) by ozlabs.org (Postfix) with SMTP id BE7C4B7D50
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Mar 2010 11:59:24 +1100 (EST)
Message-ID: <4BA41DE7.70406@yahoo.es>
Date: Sat, 20 Mar 2010 01:59:19 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v5 08/10] wii: add mem2 dma mapping ops
References: <1269023546-25534-1-git-send-email-albert_herranz@yahoo.es>
	<1269023546-25534-9-git-send-email-albert_herranz@yahoo.es>
	<20100319195013.GC31908@phenom.dumpdata.com>
In-Reply-To: <20100319195013.GC31908@phenom.dumpdata.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Konrad Rzeszutek Wilk wrote:
>> +int wii_set_mem2_dma_constraints(struct device *dev)
>> +{
>> +	struct dev_archdata *sd;
>> +
>> +	sd = &dev->archdata;
>> +	sd->max_direct_dma_addr = 0;
>> +	sd->min_direct_dma_addr = wii_hole_start + wii_hole_size;
>> +
>> +	set_dma_ops(dev, &wii_mem2_dma_ops);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(wii_set_mem2_dma_constraints);
> 
> Can you make them EXPORT_SYMBOL_GPL?

Sure. I don't know why I didn't use the *_GPL flavour on first place.

Thanks,
Albert
