Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 49B70DDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 17:25:32 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so77793ugf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 00:25:31 -0700 (PDT)
Message-ID: <528646bc0704170025h42bdc44ava3b828d50465e39d@mail.gmail.com>
Date: Tue, 17 Apr 2007 01:25:31 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH 5/5] lite5200b suspend: low-power mode
In-Reply-To: <20070417071148.GM18236@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070315103959.GA22215@moe.telargo.com>
	<20070315104447.GG22215@moe.telargo.com>
	<528646bc0703150709v49af8085p959bd36e0adf1e4a@mail.gmail.com>
	<20070417071148.GM18236@moe.telargo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/17/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> Low-power mode implementation for Lite5200b.  (Most of devices
> on board, including the CPU, are powered down)
>
> Some I/O registers are also saved here.
>
> A patch to U-Boot that wakes up SDRAM, and transfers control
> to address saved at physical 0x0 is needed, and is already
> merged in git://www.denx.de/git/u-boot-ppc4xx.git tree.
>
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
