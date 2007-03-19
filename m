Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 81BB3DDEC4
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 01:50:40 +1100 (EST)
Subject: Re: [PATCH 4/5] powermac: proper sleep management
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <20070319105359.744830000@sipsolutions.net>
References: <20070319105352.771599000@sipsolutions.net>
	<20070319105359.744830000@sipsolutions.net>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 15:50:35 +0100
Message-Id: <1174315836.5044.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This updated version removes the sys_sync() call that can't be done with
> processes frozen.

Is the generic code still sync'ing beforehand ?

Ben.
