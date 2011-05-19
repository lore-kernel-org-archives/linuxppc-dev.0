Return-Path: <max@stro.at>
Received: from vostochny.stro.at (vostochny.stro.at [78.47.22.85])
	by ozlabs.org (Postfix) with ESMTP id A8ACAB6F7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 21:20:22 +1000 (EST)
Date: Thu, 19 May 2011 13:20:20 +0200
From: maximilian attems <max@stro.at>
To: Matthias Klose <doko@ubuntu.com>
Subject: Re: [PATCH] [klibc] ppc64: Fix build failure with stricter as
Message-ID: <20110519112019.GC21271@stro.at>
References: <1305726080-27589-1-git-send-email-max@stro.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305726080-27589-1-git-send-email-max@stro.at>
Cc: klibc@zytor.com, linuxppc-dev@lists.ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 18 May 2011, maximilian attems wrote:

> From: Matthias Klose <doko@ubuntu.com>
> 
> Landed in Ubuntu klibc version 1.5.20-1ubuntu3.
> 
> 
> Signed-off-by: maximilian attems <max@stro.at>
> ---
>  usr/klibc/arch/ppc64/crt0.S |   17 +++++++++--------
>  1 files changed, 9 insertions(+), 8 deletions(-)
> 

thank you, merged in klibc git, will be in next 1.5.23.

-- 
maks
