Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2FA0DDFDC
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 18:33:06 +1000 (EST)
Date: Tue, 14 Apr 2009 10:32:49 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] therm_pm72: Convert to a new-style i2c driver
Message-ID: <20090414103249.08cb65d4@hyperion.delvare>
In-Reply-To: <18915.50615.952282.915946@cargo.ozlabs.ibm.com>
References: <20090413160927.3b8675b8@hyperion.delvare>
	<18915.50615.952282.915946@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

On Tue, 14 Apr 2009 09:07:35 +1000, Paul Mackerras wrote:
> Jean Delvare writes:
> 
> > The legacy i2c binding model is going away soon, so convert the
> > macintosh therm_pm72 driver to the new model or it will break.
> > 
> > This is really a quick and dirty conversion, that should do the trick
> > for now, but no doubt that something cleaner can be done if anyone is
> > interested.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Seems to work fine on my powermac7,2 machine (dual 2.0GHz G5).

Excellent, thanks a lot for the fast testing!

I'll try to convert the remaining powermac drivers by the end of the
week, but I wouldn't mind if somebody with more knowledge of these
drivers than me wants to help. Basically the remaining 5 drivers must
be converted the same way I did for the therm_pm72 driver.

-- 
Jean Delvare
