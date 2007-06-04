Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/21] spufs: Add support for SPU single stepping
Date: Mon, 4 Jun 2007 23:06:08 +1000
References: <20070604051542.43B6CDDE27@ozlabs.org>
In-Reply-To: <20070604051542.43B6CDDE27@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706042106.11556.jk@ozlabs.org>
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

> This patch adds support for SPU single stepping. The single
> step bit is set in the SPU when the current process is
> being single-stepped via ptrace. The spu then stops and
> returns with a specific flag set and the syscall exit code
> will generate the SIGTRAP.

Acked-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy
