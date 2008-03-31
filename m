Return-Path: <dan.j.williams@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.188])
	by ozlabs.org (Postfix) with ESMTP id 82E17DE255
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 02:37:43 +1000 (EST)
Received: by ti-out-0910.google.com with SMTP id y6so577074tia.13
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 09:37:41 -0700 (PDT)
Message-ID: <e9c3a7c20803310937l52fdc82ejc493abbac347d427@mail.gmail.com>
Date: Mon, 31 Mar 2008 09:37:39 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
Sender: dan.j.williams@gmail.com
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] fsldma: Use compatiable binding as spec
In-Reply-To: <Pine.LNX.4.64.0803311115540.5470@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.64.0803311115540.5470@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 31, 2008 at 9:17 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
> Documentation/powerpc/booting-without-of.txt specifies the
>  compatiables we should bind to for this driver (elo, eloplus).
>  Use these instead of the extremely specific 'mpc8540' and 'mpc8349'
>  compatiables.
>
>  Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>  ---
>
>  Dan, if you don't have any issue with this I'll sent it via the powerpc
>  tree (since its not really about functionality).
>

Acked-by: Dan Williams <dan.j.williams@intel.com>
