Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f184.google.com (mail-yw0-f184.google.com
	[209.85.211.184]) by ozlabs.org (Postfix) with ESMTP id 528DFB7080
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Mar 2010 17:18:39 +1100 (EST)
Received: by ywh14 with SMTP id 14so1371497ywh.15
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Mar 2010 23:18:37 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100319060621.GC28042@obsidianresearch.com>
References: <20100309193021.GD30462@obsidianresearch.com>
	<1268977838.8599.53.camel@pasglop>
	<20100319060621.GC28042@obsidianresearch.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 19 Mar 2010 00:18:17 -0600
Message-ID: <fa686aa41003182318t72827aa9s2856c34f8f67bc61@mail.gmail.com>
Subject: Re: [PATCH] PPC: Skip over OF_DT_NOP when unflattening the device
	tree
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 19, 2010 at 12:06 AM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Fri, Mar 19, 2010 at 04:50:38PM +1100, Benjamin Herrenschmidt wrote:
>> On Tue, 2010-03-09 at 12:30 -0700, Jason Gunthorpe wrote:
>> > NOPs within the property section are skipped, but NOPs between
>> > OF_DT_END_NODE and OF_DT_BEGIN_NODE were not. My firmware NOPs out
>> > entire nodes depending on various environment parameters.
>> >
>> > of_scan_flat_dt already handles NOP more generally..
>>
>> Good catch, though that code has now moved over to drivers/of
>> and is a bit different. Grant is going to fix it up though.
>
> Ah, I based the patch off 2.6.33..
>
> Grant: let me know if you need some help/testing, nice to run into you
> again.

Would be nice if you could respin and test your patch against 2.6.34-rc1.  :-)

Otherwise I'll look at it tomorrow.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
