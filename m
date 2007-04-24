Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7F102DDF3E
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 04:54:07 +1000 (EST)
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 9FFB498642
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 20:54:05 +0200 (CEST)
Received: from ibook.aepfle.de (DSL01.83.171.145.224.ip-pool.NEFkom.net
	[83.171.145.224])
	by mail.mnet-online.de (Postfix) with ESMTP id 965F290C75
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 20:54:05 +0200 (CEST)
Date: Tue, 24 Apr 2007 20:54:02 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] generic check_legacy_ioport
Message-ID: <20070424185402.GA16077@aepfle.de>
References: <20070417210745.GA3567@aepfle.de>
	<20070423081540.GA28244@aepfle.de>
	<1177376000.14873.38.camel@localhost.localdomain>
	<20070424112530.GA11489@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070424112530.GA11489@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 24, Olaf Hering wrote:

> > And also check now if the parent is "isa". Just to be sure. If a
> > platform won't match that, then it will need it's own
> > check_legacy_ioport which is fine with me.
> 
> Do you think a device_type fdc, i8042 or ipmi will appear outside an isa
> node?

Does anyone know where those ipmi devices appear in the device-tree?
