Return-Path: <richardcochran@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 81E63B6F8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Mar 2011 02:17:34 +1100 (EST)
Received: by bwz10 with SMTP id 10so140205bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Mar 2011 08:17:30 -0700 (PDT)
Date: Thu, 24 Mar 2011 16:17:19 +0100
From: Richard Cochran <richardcochran@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: add clock_adjtime for powerpc
Message-ID: <20110324151719.GA6738@riccoc20.at.omicron.at>
References: <20110324150517.GA6710@riccoc20.at.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110324150517.GA6710@riccoc20.at.omicron.at>
Cc: linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 24, 2011 at 04:05:17PM +0100, Richard Cochran wrote:
> This patch adds the clock_adjtime system call to the powerpc architecture.

Never mind this patch.

Stephen Rothwell already posted a patch on linuxppc-dev adding this
syscall eariler today.

Thanks,
Richard
