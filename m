Return-Path: <bzolnier@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by ozlabs.org (Postfix) with ESMTP id C5627DE141
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Aug 2008 02:33:50 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so543989fga.39
	for <linuxppc-dev@ozlabs.org>; Fri, 08 Aug 2008 09:33:48 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] cleanup powerpc/include/asm/ide.h
Date: Fri, 8 Aug 2008 18:22:16 +0200
References: <20080808151849.GB14495@cs181140183.pp.htv.fi>
In-Reply-To: <20080808151849.GB14495@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808081822.17118.bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 08 August 2008, Adrian Bunk wrote:
> This patch removes code that became unused through IDE changes and the 
> arch/ppc/ removal.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

applied
