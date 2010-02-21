Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 007B4B7CE7
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Feb 2010 12:18:38 +1100 (EST)
Date: Sat, 20 Feb 2010 20:11:55 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: Feng Kan <fkan@amcc.com>
Subject: Re: [PATCH 1/1] NDFC: add support for alternate ECC format for ndfc
Message-ID: <20100220201155.27744439@opus.seanm.ca>
In-Reply-To: <1266534678-30293-1-git-send-email-fkan@amcc.com>
References: <1266534678-30293-1-git-send-email-fkan@amcc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Feng Kan <fkan@amcc.com>, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 18 Feb 2010 15:11:18 -0800
Feng Kan <fkan@amcc.com> wrote:

> This is to lock down the ordering in the correction routine against
> the calculate routine. Otherwise, incorrect define would cause ECC
> errors.

Did you actually find a 44x PPC core that is not NAND_ECC_SMS format?

Cheers,
   Sean
