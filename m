Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C8C71DDFC6
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 01:58:47 +1000 (EST)
Date: Thu, 12 Apr 2007 17:59:29 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] autodetect serial console on efika
Message-ID: <20070412155929.GA28123@aepfle.de>
References: <20070331150823.GA25421@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070331150823.GA25421@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 31, Olaf Hering wrote:

> Efika boards have to be booted with console=ttyPSC0 unless there is a
> graphics card plugged in. Detect if the firmware stdout is the serial
> connector.

Paul, please discard this patch. The optional graphics card may have
also device_type 'serial' if it is in VGA mode.
I will send an updated patch later.
