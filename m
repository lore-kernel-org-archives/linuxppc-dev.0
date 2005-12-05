Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17299.48715.240227.420852@cargo.ozlabs.ibm.com>
Date: Mon, 5 Dec 2005 15:12:59 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051203104639.4b477dea.akpm@osdl.org>
References: <11336348593561-git-send-email-otavio@debian.org>
	<20051203104639.4b477dea.akpm@osdl.org>
Cc: linuxppc-dev@ozlabs.org, Otavio Salvador <otavio@debian.org>
Subject: Re: [PATCH] arch/ppc/kernel/idle.c: don't declare cpu variable in
 non-SMP kernels
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton writes:

> Surely this would be better?

Yes it would, care to give me a signed-off-by for it? :)

Paul.
