Return-Path: <michel@tungstengraphics.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 0D3D4DE0D6
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 18:39:17 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so369251ugf
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 23:39:15 -0800 (PST)
Subject: Re: [PATCH 2/3] powermac: proper time of day after resume
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1169675091.18754.84.camel@localhost.localdomain>
References: <20061213123819.403286000@sipsolutions.net>
	<20061213123945.386891000@sipsolutions.net>
	<1169620444.18754.66.camel@localhost.localdomain>
	<20070124085420.GA19810@iram.es>
	<1169631177.18754.82.camel@localhost.localdomain>
	<20070124103621.GA22579@iram.es>
	<2435847C-A9FC-4430-A122-416B9B347038@kernel.crashing.org>
	<1169675091.18754.84.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jan 2007 08:39:14 +0100
Message-Id: <1169710754.24087.36.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-01-25 at 08:44 +1100, Benjamin Herrenschmidt wrote:
> > > The best solution may require informing the user space ntp code of
> > > such events. This requires very likely modifications to ntp itself
> > > (I may be wrong, I've not looked at NTP code for 5 years or so).
> > 
> > Doesn't the kernel send signals to init on suspend/resume
> > events, just like with power fail events?  You can hook on
> > that.
> 
> I don't think it does... at least not on powerbooks.

It could be handled by scripts invoked from pbbuttonsd or pmud on wakeup
though, couldn't it? I thought there used to be one for that
in /etc/apm/, but I can't find it now...


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
