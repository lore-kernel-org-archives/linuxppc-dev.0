Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id 34CF967BD9
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 13:04:58 +1100 (EST)
Received: from mail7.sony.co.jp (localhost [127.0.0.1])
	by mail7.sony.co.jp (R8/Sony) with ESMTP id kAH24umD016255
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 11:04:56 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail7.sony.co.jp (R8/Sony) with SMTP id kAH24u0l016240
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 11:04:56 +0900 (JST)
Message-ID: <455D18B8.8090006@am.sony.com>
Date: Thu, 16 Nov 2006 18:04:40 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
References: <4554DACB.8060809@am.sony.com> <20061115180440.GB18856@lst.de>	
	<1163723984.5940.411.camel@localhost.localdomain>	
	<455D1161.2020605@am.sony.com>
	<1163727734.16815.24.camel@localhost.localdomain>
In-Reply-To: <1163727734.16815.24.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Thu, 2006-11-16 at 17:33 -0800, Geoff Levand wrote:
>> Benjamin Herrenschmidt wrote:
>> >> > +
>> >> > +enum page_size {
>> >> > +	page_size_4k = 12U,
>> >> > +	page_size_64k = 16U,
>> >> > +	page_size_16m = 24U,
>> >> > +};
>> >> 
>> >> Please use ALL_CAPS for such constants.
>> > 
>> > And call them PAGE_SHIFT_* while at it :-)
>> 
>> The HV docs call this page size, so that is what I used for
>> the symbol.  I'll look at the usage again and reconsider.
> 
> No need to look at it, it's a shift not a size, the page size is not 12
> bytes. Keeping it consistent with the HV docs is a concern, but so is
> making it consistent with every other part of the kernel - which calls
> this a shift, see page.h f.e.

Well, I meant reconsider in more of a broad sense, in like, maybe I can just do
something to get rid of it...
