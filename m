Return-Path: <SRS0=YHklx0=YI=writeme.com=sinan@yourhostingaccount.com>
Received: from mailout07.yourhostingaccount.com
	(mailout07.yourhostingaccount.com [65.254.253.61])
	by ozlabs.org (Postfix) with ESMTP id 538B4DE3BA
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 23:20:10 +1000 (EST)
Received: from mailscan04.yourhostingaccount.com ([10.1.15.4]
	helo=mailscan04.yourhostingaccount.com)
	by mailout07.yourhostingaccount.com with esmtp (Exim)
	id 1KNSAV-00019b-EH
	for linuxppc-dev@ozlabs.org; Mon, 28 Jul 2008 08:49:39 -0400
Message-ID: <488DC046.7060802@writeme.com>
Date: Mon, 28 Jul 2008 08:49:10 -0400
From: Sinan Akman <sinan@writeme.com>
MIME-Version: 1.0
To: Karsten Keil <kkeil@suse.de>
Subject: Re: mISDN still breaking the allmodconfig build...
References: <20080727.170235.97056809.davem@davemloft.net>	<93120C4B-D2F4-4479-806B-2141AC3DC607@holtmann.org>	<20080727.180736.74131389.davem@davemloft.net>	<7949EA87-4340-4353-AFC9-79A718B95DF0@holtmann.org>
	<20080728084024.GA23465@pingi.kke.suse.de>
In-Reply-To: <20080728084024.GA23465@pingi.kke.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: Sinan Akman <sinan@writeme.com>
Cc: sfr@canb.auug.org.au, Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Karsten Keil wrote:
> [...]
> virt_to_bus() I never got a complain before and yes I already have some patches
> to solve the endian issues in the HFC driver, but it was not finaly

   Karsten, do you have those patches available somewhere ?
I could give it a try on  4xx with a 4s card in the near future.

   Thanks

   Sinan Akman
