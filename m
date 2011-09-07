Return-Path: <geoff@infradead.org>
Message-ID: <4E67A417.3000309@infradead.org>
Date: Wed, 7 Sep 2011 10:04:23 -0700
From: Geoff Levand <geoff@infradead.org>
MIME-Version: 1.0
To: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: [PATCH 51/62] powerpc/ps3: irq: Remove IRQF_DISABLED
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
	<1315383059-3673-52-git-send-email-yong.zhang0@gmail.com>
In-Reply-To: <1315383059-3673-52-git-send-email-yong.zhang0@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: cbe-oss-dev@lists.ozlabs.org, tglx@linutronix.de, mingo@elte.hu,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/07/2011 01:10 AM, Yong Zhang wrote:
> This flag is a NOOP and can be removed now.
> 
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> ---
>  drivers/ps3/ps3-vuart.c   |    2 +-
>  drivers/ps3/ps3stor_lib.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Geoff Levand <geoff@infradead.org>
