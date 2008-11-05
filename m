Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id 41908DDDFF
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 10:15:04 +1100 (EST)
Date: Thu, 6 Nov 2008 00:14:59 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] Re: rtc-ppc
Message-ID: <20081106001459.7eba302f@i1501.lan.towertech.it>
In-Reply-To: <20081105230825.GA28465@yookeroo.seuss>
References: <20081105021901.49dffc3e@i1501.lan.towertech.it>
	<1225923526.3882.3.camel@macbook.infradead.org>
	<20081105230825.GA28465@yookeroo.seuss>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 6 Nov 2008 10:08:25 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> > I think we're waiting until the RTC class works with NTP before we can
> > contemplate that, though.  
> 
> Yeah, I tried writing some ppc_md hooks which backended onto the rtc
> class drivers as an interim measure, but the hooks are called from
> places the rtc class stuff can't safely be called (too early, IIRC,
> but it's a while since I checked).

 I think the rtc drivers are too heterogeneous to have a valid
 ntp strategy. 

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
