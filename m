Return-Path: <jonsmirl@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.178])
	by ozlabs.org (Postfix) with ESMTP id 5BB2CDDF70
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 23:21:10 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id o28so776157ele.3
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 06:21:08 -0700 (PDT)
Message-ID: <9e4733910807140621g69707c46tc23d26e9cf030c5c@mail.gmail.com>
Date: Mon, 14 Jul 2008 09:21:08 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 5/5] powerpc/mpc5200: Add mpc5200-spi (non-PSC) device
	driver
In-Reply-To: <20080712083458.14782.59382.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080712083437.14782.65551.stgit@trillian.secretlab.ca>
	<20080712083458.14782.59382.stgit@trillian.secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/12/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
>  Adds support for the dedicated SPI device on the Freescale MPC5200(b)
>  SoC.

Can you adjust the existing PSC based SPI driver to use this device
tree code? It will be confusing if there are two different ways to do
SPI on the mpc5200.

-- 
Jon Smirl
jonsmirl@gmail.com
