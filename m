Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C038BDDF72
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 13:31:00 +1000 (EST)
Subject: Re: [PATCH 2/11] cell: generalize io-workarounds code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <20080424.120722.-1300531374.kouish@swc.toshiba.co.jp>
References: <20080424.120722.-1300531374.kouish@swc.toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 24 Apr 2008 13:30:54 +1000
Message-Id: <1209007854.9060.115.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-04-24 at 12:07 +0900, Ishizaki Kou wrote:
> 
> I'm sorry to have kept you waiting for my response.
> 
> I just finished reviewing your patch.  Your patch works well on
> Celleb, and I found I also should do the same thing for Celleb as you
> pointed.  I will send a new patch which includes your fix.

Thanks. Please do so ASAP as tomorrow is non-working day and we are
getting close to -rc1.

Cheers,
Ben.
