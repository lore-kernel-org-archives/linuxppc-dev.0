Return-Path: <dan.j.williams@gmail.com>
Received: from mail-fx0-f44.google.com (mail-fx0-f44.google.com
	[209.85.161.44]) by ozlabs.org (Postfix) with ESMTP id E6509B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Dec 2010 09:02:42 +1100 (EST)
Received: by fxm9 with SMTP id 9so7012124fxm.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Dec 2010 14:02:39 -0800 (PST)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <1291882444-1523-1-git-send-email-leoli@freescale.com>
References: <1291882444-1523-1-git-send-email-leoli@freescale.com>
Date: Mon, 13 Dec 2010 14:02:39 -0800
Message-ID: <AANLkTinvCek5B-4kgnm-A7=xuhS9yK6fjotNKaeO1e=T@mail.gmail.com>
Subject: Re: [PATCH] fsldma: fix issue of slow dma
From: Dan Williams <dan.j.williams@intel.com>
To: Li Yang <leoli@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 9, 2010 at 12:14 AM, Li Yang <leoli@freescale.com> wrote:
> From: Forrest Shi <b29237@freescale.com>
>
> Fixed fsl dma slow issue by initializing dma mode register with
> bandwidth control. It boosts dma performance and should works
> with 85xx board.
>
> Signed-off-by: Forrest Shi <b29237@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>

Applied.
