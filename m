Return-Path: <dg@emlix.com>
Received: from mx1.emlix.com (mx1.emlix.com [193.175.82.87])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6699BB6F01
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 20:28:24 +1000 (EST)
Message-ID: <4C2B140B.4050004@emlix.com>
Date: Wed, 30 Jun 2010 11:53:15 +0200
From: =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/9] Add Synopsys DesignWare HS USB OTG Controller driver.
References: <5569.83301.qm@web180304.mail.gq1.yahoo.com>
In-Reply-To: <5569.83301.qm@web180304.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>, gregkh@suse.de,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/30/2010 12:41 AM, David Brownell wrote:
> Could you mention a few Linux-enabled chips which
> include this controller?

Ralink APSoC chips (rt2880, rt305x) do:
http://svn.dd-wrt.com:8000/dd-wrt/browser/src/linux/rt2880/linux-2.6.23/drivers/usb/dwc_otg/Kconfig

  Daniel

-- 
Dipl.-Math. Daniel Glöckner, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführer: Dr. Uwe Kracke, Ust-IdNr.: DE 205 198 055

emlix - your embedded linux partner
