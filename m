Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19158.17068.783793.356509@cargo.ozlabs.ibm.com>
Date: Thu, 15 Oct 2009 08:29:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] powerpc: Prevent unsigned wrap in
	htab_dt_scan_page_sizes()
In-Reply-To: <4AD5C01E.8000600@gmail.com>
References: <4AD5C01E.8000600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Roel Kluin writes:

> Check to prevent unsigned wrap of size before subtraction.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> Is this maybe better or are we certain that size can't wrap?

Patch looks good, though while you're at it, you could add a space
after the "while".

Acked-by: Paul Mackerras <paulus@samba.org>
