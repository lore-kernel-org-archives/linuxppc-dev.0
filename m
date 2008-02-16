Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <47B72E70.1030708@am.sony.com>
Date: Sat, 16 Feb 2008 10:41:52 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: [PATCH 1/3] Fix Unlikely(x) == y
References: <47B70A61.9030306@tiscali.nl>
In-Reply-To: <47B70A61.9030306@tiscali.nl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 02/16/2008 08:08 AM, Roel Kluin wrote:
> The patch below was not yet tested. If it's correct as it is, please comment.

> -	if (unlikely(plug) == NO_IRQ) {
> +	if (unlikely(plug == NO_IRQ)) {

A good catch!  I'll put it in with some other 2.6.25 bug fixes.

-Geoff
