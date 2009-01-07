Return-Path: <timur.tabi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id 5969ADE176
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 07:17:06 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so5413130qwb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Jan 2009 12:17:04 -0800 (PST)
Message-ID: <ed82fe3e0901071217y44900869n7af2e99d6174fd45@mail.gmail.com>
Date: Wed, 7 Jan 2009 14:17:04 -0600
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: netdev@vger.kernel.org, leoli@freescale.com, davem@davemloft.net,
	galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ucc_geth: use correct UCCE macros
In-Reply-To: <1231359172-6119-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1231359172-6119-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 7, 2009 at 2:12 PM, Timur Tabi <timur@freescale.com> wrote:

> This patch will break ucc_geth.c if my other patch, "powerpc: add Ethernet
> UPSMR definitions to QE library" isn't also applied.  That patch is currently
> in Kumar's 'next' branch, so it will make 2.6.29-rc0.  Therefore, it should
> be safe to apply this patch to 'net-next' today, with the understanding that
> everything will be peachy once Linus pulls everyone's 2.6.29 branches.

David,

as I mentioned here, Kumar already has the pre-req patch in his 'next'
branch (for 2.6.29), so if you apply this patch to your 'next',
ucc_geth.c will break until Linus pulls from Kumar and you pull from
Linus.  I think that's OK.

-- 
Timur Tabi
Linux kernel developer at Freescale
