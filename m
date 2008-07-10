Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] spufs: correct kcalloc usage
Date: Fri, 11 Jul 2008 09:04:13 +1000
References: <for-27-patch8-4@bga.com>
In-Reply-To: <for-27-patch8-4@bga.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Message-Id: <200807110904.14429.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton,

> kcalloc is supposed to be called with the count as its first argument
> and the element size as the second.

Thanks, applied.

Cheers,


Jeremy
