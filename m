Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 03857DE01C
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 07:40:08 +1100 (EST)
Message-ID: <45BA671E.6040304@am.sony.com>
Date: Fri, 26 Jan 2007 12:39:58 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/14] ps3: repository misc fixes
References: <45B81869.6070305@am.sony.com> <20070126025741.GD18537@lst.de>
	<20070126030113.GF18537@lst.de>
In-Reply-To: <20070126030113.GF18537@lst.de>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig wrote:
> On Fri, Jan 26, 2007 at 03:57:41AM +0100, Christoph Hellwig wrote:
>> On Wed, Jan 24, 2007 at 06:39:37PM -0800, Geoff Levand wrote:
>> > +EXPORT_SYMBOL_GPL(ps3_repository_read_bus_id);
>> 
>> > +EXPORT_SYMBOL_GPL(ps3_repository_read_bus_type);
>> 
>> > +EXPORT_SYMBOL_GPL(ps3_repository_read_bus_num_dev);
>> 
>> > +EXPORT_SYMBOL_GPL(ps3_repository_read_dev_id);
>> 
>> > +EXPORT_SYMBOL_GPL(ps3_repository_read_dev_type);
>> 
>> > +EXPORT_SYMBOL_GPL(ps3_repository_read_dev_intr);
>> 
>> > +EXPORT_SYMBOL_GPL(ps3_repository_find_device);
>> 
>> > +EXPORT_SYMBOL_GPL(ps3_repository_read_stor_dev_info);
>> 
>> > +EXPORT_SYMBOL_GPL(ps3_repository_read_stor_dev_region);
>> 
>> 
>> Exporting all these as procedural interfaces is very wrong.  Please
>> implement a proper bustype for your hypervisor devices where all this
>> information is an attribute of the hv1_device object.
> 
> In addition to that there's no user of these exports in this patch,
> so there is no point in adding any kind of export for this type of
> information at all yet.  (until we have a proper storage driver)

Both good points.  I'll remove this from the patch and rework it
for later submission.

-Geoff
