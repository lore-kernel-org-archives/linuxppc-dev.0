Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id 4FD7CDDED1
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 10:06:42 +1100 (EST)
Date: Wed, 5 Nov 2008 23:59:55 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: rtc-ppc
Message-ID: <20081105235955.28436136@i1501.lan.towertech.it>
In-Reply-To: <1225923526.3882.3.camel@macbook.infradead.org>
References: <20081105021901.49dffc3e@i1501.lan.towertech.it>
	<1225923526.3882.3.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 05 Nov 2008 23:18:46 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> It would be possible, yes -- but it would be better to have the various
> PPC platforms just register RTC-class devices _directly_, and ditch the
> RTC bits from ppc_md altogether.

 That would be real fine :)

> I think we're waiting until the RTC class works with NTP before we can
> contemplate that, though.

 That will be a long wait, I don't think anyone volunteered for
 the ntp code. I've been told some platforms are already using the class.


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
