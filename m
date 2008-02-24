Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <47C1BC31.9070402@am.sony.com>
Date: Sun, 24 Feb 2008 10:49:21 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH] ps3: Fix "unlikely" incorrect usage
References: <20080224081037.D492320AFF@arrakis.enst.fr>
In-Reply-To: <20080224081037.D492320AFF@arrakis.enst.fr>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 02/24/2008 12:06 AM, Samuel Tardieu wrote:
> Fix unlikely(plug) == NO_IRQ into unlikely(plug == NO_IRQ).
> 
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
> ---
>  arch/powerpc/platforms/ps3/interrupt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Thanks for the submission, but this fix is already in
ps3-linux.git.  I was waiting to collect a few other bugs
before sending it to Paul.

-Geoff
