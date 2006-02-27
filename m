Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 3C86D67A00
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2006 08:35:46 +1100 (EST)
Date: Mon, 27 Feb 2006 13:35:09 -0800
To: Olof Johansson <olof@lixom.net>
Subject: Re: copying /sys causes fans to spin up
Message-ID: <20060227213509.GD4685@pb15.lixom.net>
References: <20060227160911.GA17569@suse.de>
	<1141075795.4809.15.camel@localhost.localdomain>
	<20060227213319.GC4685@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060227213319.GC4685@pb15.lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: Olaf Hering <olh@suse.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 27, 2006 at 01:33:19PM -0800, Olof Johansson wrote:

> For me it's /sys/devices/system/windfarm.0/hd-temp

-EBADCRACK

/sys/devices/platform/windfarm.0/hd-temp, I mean. And it's enough to cat
the file for it to happen.
