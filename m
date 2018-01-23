Return-Path: <frowand.list@gmail.com>
Received: from mail-pg0-x231.google.com (mail-pg0-x231.google.com
 [IPv6:2607:f8b0:400e:c05::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQzWd4504zDrCc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 06:53:49 +1100 (AEDT)
Received: by mail-pg0-x231.google.com with SMTP id y27so1011127pgc.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 11:53:49 -0800 (PST)
Subject: Re: [RFC PATCH v2 0/1] of: easier debugging for node life cycle issues
To: Michael Ellerman <mpe@ellerman.id.au>, Wolfram Sang <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Rob Herring <robh+dt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20180121143117.19805-1-wsa+renesas@sang-engineering.com>
 <ac4f02e1-6d49-158a-4fb6-56ac0d474a44@gmail.com>
 <20180122114948.mm5mg6zqw3hmjj4o@katana>
 <874lncwza1.fsf@concordia.ellerman.id.au>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <533b27ea-f1e4-edab-0a35-a4304483d026@gmail.com>
Date: Tue, 23 Jan 2018 11:53:44 -0800
MIME-Version: 1.0
In-Reply-To: <874lncwza1.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/23/18 04:11, Michael Ellerman wrote:
> Wolfram Sang <wsa@the-dreams.de> writes:
> 
>> Hi Frank,
>>
>>> Please go back and read the thread for version 1.  Simply resubmitting a
>>> forward port is ignoring that whole conversation.
>>>
>>> There is a lot of good info in that thread.  I certainly learned stuff in it.
>>
>> Yes, I did that and learned stuff, too. My summary of the discussion was:
>>
>> - you mentioned some drawbacks you saw (like the mixture of trace output
>>   and printk output)
>> - most of them look like addressed to me? (e.g. Steven showed a way to redirect
>>   printk to trace)
>> - you posted your version (which was, however, marked as "not user friendly"
>>   even by yourself)
>> - The discussion stalled over having two approaches
>>
>> So, I thought reposting would be a good way of finding out if your
>> concerns were addressed in the discussion or not. If I overlooked
>> something, I am sorry for that. Still, my intention is to continue the
>> discussion, not to ignore it. Because as it stands, we don't have such a
>> debugging mechanism in place currently, and with people working with DT
>> overlays, I'd think it would be nice to have.
> 
> Yeah I agree with all of that, I didn't think there were really any
> concerns left outstanding. These trace points are very useful, I've
> twice added them to a kernel to debug something, so it would be great
> for them to be in mainline.
> 
> cheers
> 

Yes, I believe there are concerns outstanding.  I'll try to read through
the whole thread today to make sure I'm not missing anything.

-Frank
