Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id ED51BDDDFC
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 12:56:32 +1100 (EST)
Date: Fri, 25 Jan 2008 18:09:14 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] create modalias file in sysfs for bus vio
Message-ID: <20080125170914.GA29887@aepfle.de>
References: <20080122083328.GA11928@aepfle.de>
	<20080123010505.d812129e.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080123010505.d812129e.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 23, Stephen Rothwell wrote:

> It would be nice if we could factor out the "vio:T%sS%s" string as it is
> also used in vio_hotplug().

What exactly do you have in mind?
Creating a tempstring seems to make things more complicated.
