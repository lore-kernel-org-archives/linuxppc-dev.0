Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1FDBF67C67
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 08:24:21 +1100 (EST)
Date: Wed, 6 Dec 2006 22:24:15 +0100
From: Olaf Hering <olh@suse.de>
To: Anton Blanchard <anton@samba.org>
Subject: Re: 2.6.19 cannot find root partition
Message-ID: <20061206212415.GA26385@suse.de>
References: <20061206211630.GB27857@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20061206211630.GB27857@krispykreme>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 07, Anton Blanchard wrote:

> The install in question was debian etch. Im not sure what the best fix
> is, perhaps the AIX detection code could check more than the first 4
> bytes.

Can you send me a dump of the first block?
