Return-Path: <mjw@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 31283B6EF4
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 09:47:58 +1100 (EST)
Subject: Re: [PATCH 6/8] Use proper types for do_div
From: Mark Wielaard <mjw@redhat.com>
To: avorontsov@ru.mvista.com
In-Reply-To: <20091209160941.GA8539@oksana.dev.rtsoft.ru>
References: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
	<20091127223347.GF21805@oksana.dev.rtsoft.ru>
	<1260374194.31018.11.camel@springer.wildebeest.org>
	<20091209160941.GA8539@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Dec 2009 23:47:54 +0100
Message-Id: <1260398874.509.1.camel@hermans.wildebeest.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, systemtap@sourceware.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton,

On Wed, 2009-12-09 at 19:09 +0300, Anton Vorontsov wrote:
> I think this should be fixed by this patch:
> 
> http://sourceware.org/ml/systemtap/2009-q4/msg00800.html
> 
> Can you try it? With this patch I see no new regressions on x86_64.

Yes, that fixes everything. Sorry I didn't see that patch earlier. I see
Wenji also tested it already. I have pushed it for you.

Thanks,

Mark
