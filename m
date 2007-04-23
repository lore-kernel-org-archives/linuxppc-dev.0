Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 3696FDDF10
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 21:30:11 +1000 (EST)
Date: Mon, 23 Apr 2007 06:49:17 -0500
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [PATCH] [v2] powerpc: save trap number in bad_stack
Message-ID: <20070423114917.GA476@lixom.net>
References: <20070416062347.GA20196@lixom.net>
	<20070422233821.GB28479@lixom.net> <20070423092919.GA25145@iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070423092919.GA25145@iram.es>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 23, 2007 at 11:29:19AM +0200, Gabriel Paubert wrote:

> stW to an u16? stH seems safer!

Yes, thanks. my bad.

-Olof
