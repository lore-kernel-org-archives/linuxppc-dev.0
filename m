Return-Path: <jwboyer@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.227])
	by ozlabs.org (Postfix) with ESMTP id 3EF6FDDEF0
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 07:56:11 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g9so2224034rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 13:56:09 -0700 (PDT)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Mon, 30 Mar 2009 16:55:53 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hvc_console: prevent wrapping in hvc_console_print()
Message-ID: <20090330205553.GA19278@yoda.jdub.homelinux.org>
References: <49BF956B.9030109@gmail.com>
	<20090330133531.f5d99c09.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090330133531.f5d99c09.akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, Roel Kluin <roel.kluin@gmail.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 30, 2009 at 01:35:31PM -0700, Andrew Morton wrote:
>Guys, could we have a MAINTAINERS entry for this driver please?

To my knowledge, there isn't one.  Would be Ben now by default I
guess.  The previous developers have disclaimed ownership for a
while from what I remember.

josh
