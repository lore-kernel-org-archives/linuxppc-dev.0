Return-Path: <pku.leo@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 0DAB2DDE26
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 15:10:55 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so916656ywt.39
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 22:10:53 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <20090428.043929.171852977.davem@davemloft.net>
References: <2a27d3730904280316l7049bddbie914907b16ccfff6@mail.gmail.com>
	<1240913737-23773-1-git-send-email-leoli@freescale.com>
	<20090428.043929.171852977.davem@davemloft.net>
Date: Thu, 30 Apr 2009 13:10:53 +0800
Message-ID: <2a27d3730904292210q67e18274nf6676a054b780639@mail.gmail.com>
Subject: Re: [PATCH] rapidio: add common mapping APIs for RapidIO memory
	access
From: Li Yang <leoli@freescale.com>
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
Cc: zw@zh-kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 28, 2009 at 7:39 PM, David Miller <davem@davemloft.net> wrote:
>
> Please number your patches. :-/
>
> There is no way for anyone to be able to tell in what order
> your changes should be applied.

Sorry for that.  I thought I have added -n when doing the
git-format-patch, but it turns out not the case. :(  Will double check
next time.

- Leo
