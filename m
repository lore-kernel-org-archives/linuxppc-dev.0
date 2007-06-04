Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/21] spufs: Add a "capabilities" file to spu contexts
Date: Mon, 4 Jun 2007 23:06:52 +1000
References: <20070604051543.7028DDDEB9@ozlabs.org>
In-Reply-To: <20070604051543.7028DDDEB9@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706042106.55595.jk@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

> This adds a "capabilities" file to spu contexts consisting of a
> list of linefeed separated capability names. The current exposed
> capabilities are "sched" (the context is scheduleable) and
> "step" (the context supports single stepping).

Looks good.

Acked-by: Jeremy Kerr <jk@ozlabs.org>


Jeremy
