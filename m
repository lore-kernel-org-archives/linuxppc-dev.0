Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F77DDE68D
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 07:29:20 +1000 (EST)
Subject: Re: [PATCH v3] leds: implement OpenFirmare GPIO LED driver
From: Nate Case <ncase@xes-inc.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080715151917.GA30607@polina.dev.rtsoft.ru>
References: <1216133032.5345.73.camel@dax.rpnet.com>
	<20080715151917.GA30607@polina.dev.rtsoft.ru>
Content-Type: text/plain
Date: Thu, 17 Jul 2008 16:29:01 -0500
Message-Id: <1216330141.7559.950.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>,
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-15 at 19:19 +0400, Anton Vorontsov wrote:
> +       led->cdev.name = of_get_property(np, "label", NULL);
> +       if (!led->cdev.name)
> +               led->cdev.name = dev_name(&ofdev->dev);

How about also supporting a "trigger" property which would set
cdev.default_trigger in the same manner?  It would be useful for boards
to be able to specify this in the device tree (e.g., if a certain LED is
meant to be used as a "heartbeat").

-- 
Nate Case <ncase@xes-inc.com>
