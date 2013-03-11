Return-Path: <geoff@infradead.org>
Message-ID: <1363037814.3155.1.camel@smoke>
Subject: Re: [PATCH] powerpc: Use PTR_RET instead of IS_ERR/PTR_ERR
From: Geoff Levand <geoff@infradead.org>
To: Adrian-Leonard Radu <ady8radu@gmail.com>
Date: Mon, 11 Mar 2013 14:36:54 -0700
In-Reply-To: <1362920820-11073-1-git-send-email-ady8radu@gmail.com>
References: <1362920820-11073-1-git-send-email-ady8radu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, fweisbec@gmail.com, akinobu.mita@gmail.com,
 rostedt@goodmis.org, linux-kernel@vger.kernel.org, paulus@samba.org,
 anton@samba.org, john.stultz@linaro.org, linuxppc-dev@lists.ozlabs.org,
 cascardo@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-03-10 at 15:07 +0200, Adrian-Leonard Radu wrote:
> Signed-off-by: Adrian-Leonard Radu <ady8radu@gmail.com>
> ---
>  arch/powerpc/kernel/iommu.c          |    2 +-
>  arch/powerpc/kernel/time.c           |    4 +---
>  arch/powerpc/platforms/ps3/time.c    |    4 +---
>  arch/powerpc/sysdev/rtc_cmos_setup.c |    5 +----
>  4 files changed, 4 insertions(+), 11 deletions(-)

ps3 part looks OK, thanks.

Acked-by: Geoff Levand <geoff@infradead.org>
