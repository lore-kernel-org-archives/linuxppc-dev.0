Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by ozlabs.org (Postfix) with ESMTP id EA4E0DDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Nov 2007 05:14:31 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id a29so8050755pyi
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Nov 2007 10:14:30 -0800 (PST)
Date: Tue, 20 Nov 2007 12:14:21 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] powerpc: Change _tlbie arguments to reflect new API
Message-ID: <20071120121421.5f20c2c6@weaponx>
In-Reply-To: <47431799.6010802@scram.de>
References: <47431799.6010802@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 20 Nov 2007 18:21:29 +0100
Jochen Friedrich <jochen@scram.de> wrote:

> A new pid argument has been added to _tlbie for 4xx platforms.
> Add this argument to the 8xx path in mem.c, as well. As 8xx
> does not need th epid information, this argument can always be 0.

This is already fixed in Paul's tree.

josh
