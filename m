Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 8C4E0DDDF5
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 21:24:42 +1000 (EST)
Date: Wed, 13 Jun 2007 13:24:48 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 29/30] PS3: Device tree source.
Message-ID: <20070613112448.GA29239@aepfle.de>
References: <20070612181825.730300780@am.sony.com>>
	<466EEC01.6080807@am.sony.com>
	<f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
	<20070613084023.GA28629@aepfle.de>
	<0502b4de346bce374f98c49a99be50c1@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <0502b4de346bce374f98c49a99be50c1@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 13, Segher Boessenkool wrote:

> Please read up on what those properties mean exactly.

Yes, do that before the inital release.

currently name contains ''
currently compatible contains 'PS3PF'
currently model contains 'PLAYSTATION 3'

Now, do not break the userspace ABI.
If there is really an urge to break it, add the new device-tree to
2.6.22 and do not change the new values anymore.
