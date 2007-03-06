Return-Path: <SRS0+c0e06a779411090cd6fe+1290+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9209FDDF10
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Mar 2007 21:35:44 +1100 (EST)
Subject: Re: PROBLEM: 2.6.20-1 not working on ibook g4 (BUG/Oops)
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Collins <paul@briny.ondioline.org>
In-Reply-To: <87tzwzqgrx.fsf@briny.internal.ondioline.org>
References: <200703051414.15802.frafore@tiscali.it>
	<1173143894.3461.240.camel@pmac.infradead.org>
	<87tzwzqgrx.fsf@briny.internal.ondioline.org>
Content-Type: text/plain
Date: Tue, 06 Mar 2007 10:35:29 +0000
Message-Id: <1173177329.3461.291.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: francesco foresti <frafore@tiscali.it>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-03-06 at 14:53 +1300, Paul Collins wrote:
> In case it's of interest, 2.6.20 has been running fine on my
> PowerBook5,4. 

How much memory? What if you boot with mem=512M or mem=256M?

It works fine on my PowerBook5,3 unless I do that.

-- 
dwmw2
