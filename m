Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 99615DDED4
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Apr 2007 16:46:18 +1000 (EST)
Date: Sun, 22 Apr 2007 08:46:14 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Milton Miller <miltonm@bga.com>
Subject: Re: generic check_legacy_ioport
Message-ID: <20070422064614.GA18796@aepfle.de>
References: <20070420185107.GA4972@aepfle.de>
	<200704220515.l3M5F7eH005962@sullivan.realtime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200704220515.l3M5F7eH005962@sullivan.realtime.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 22, Milton Miller wrote:

> These are all ifdef'd for the driver being built-in.

Yes, silly Kbuild.

> Can we write someting generic instead that finds the isa
> bus, then walks children looking for a direct child that
> has a matching reg to the requested port?

Why bother?
Nothing else has device_type xyz in the device-tree, my patch handles
all cases. The code can be updated when some new board comes along with
different requirements.
