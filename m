Return-Path: <j.glisse@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.198])
	by ozlabs.org (Postfix) with ESMTP id A85902BF17
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jan 2005 07:41:46 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 36so198622wra
	for <linuxppc-dev@ozlabs.org>; Sun, 09 Jan 2005 12:41:44 -0800 (PST)
Message-ID: <4240b91605010912414a5b1b67@mail.gmail.com>
Date: Sun, 9 Jan 2005 21:41:44 +0100
From: Jerome Glisse <j.glisse@gmail.com>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <4240b91605010909463e44bba8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <4240b916050109072621440269@mail.gmail.com>
	<20050109160614.GA22839@lst.de>
	<4240b91605010909463e44bba8@mail.gmail.com>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: U3 G5 AGP support patch (v4)
Reply-To: Jerome Glisse <j.glisse@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It seems there is bug somewhere in my agp patch. I was playing with
r300 radeon and
i get a hard lockup (quite used to that while playing with r300 thought :()

But after a bit of investigation it seems to be related to agp. Right now i am
porting an old tools from dri that test agpgart & thus agp. I finally may really
need to totaly split the u3 driver from the old uninorth.

I will give a deeper look to track down the issue. In the mean time if some
one could test agp & radeon r200 on a g5. You will certainly lockup your g5
but it should not burn, at least here i just got some smoke ;)

best,
Jerome Glisse
