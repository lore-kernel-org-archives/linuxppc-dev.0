Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id 9D3C067BDA
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 12:33:32 +1100 (EST)
Received: from mail5.sony.co.jp (localhost [127.0.0.1])
	by mail5.sony.co.jp (R8/Sony) with ESMTP id kAH1XUsa029394
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 10:33:30 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail5.sony.co.jp (R8/Sony) with SMTP id kAH1XUdI029383
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 10:33:30 +0900 (JST)
Message-ID: <455D1161.2020605@am.sony.com>
Date: Thu, 16 Nov 2006 17:33:21 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
References: <4554DACB.8060809@am.sony.com> <20061115180440.GB18856@lst.de>
	<1163723984.5940.411.camel@localhost.localdomain>
In-Reply-To: <1163723984.5940.411.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> > +
>> > +enum page_size {
>> > +	page_size_4k = 12U,
>> > +	page_size_64k = 16U,
>> > +	page_size_16m = 24U,
>> > +};
>> 
>> Please use ALL_CAPS for such constants.
> 
> And call them PAGE_SHIFT_* while at it :-)

The HV docs call this page size, so that is what I used for
the symbol.  I'll look at the usage again and reconsider.

-Geoff
