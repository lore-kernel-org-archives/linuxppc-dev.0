Return-Path: <marcel@holtmann.org>
Received: from mail.holtmann.org (senator.holtmann.net [87.106.208.187])
	by ozlabs.org (Postfix) with ESMTP id 0DCBCDDF85
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 11:21:18 +1000 (EST)
Message-Id: <93120C4B-D2F4-4479-806B-2141AC3DC607@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080727.170235.97056809.davem@davemloft.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v928.1)
Subject: Re: mISDN still breaking the allmodconfig build...
Date: Mon, 28 Jul 2008 03:03:04 +0200
References: <20080727.170235.97056809.davem@davemloft.net>
Cc: sfr@canb.auug.org.au, kkeil@suse.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Dave,

> More fallout from the premature mISDN driver merge:
>
> drivers/isdn/hardware/mISDN/hfcmulti.c:5255:2: error: #error "not  
> running on big endian machines now"

is that only the HFC driver or the whole mISDN stack?

I know that the two old ISDN stacks where really bad on big endian,  
but my assumption was that we did sort this out in the end.

Regards

Marcel
