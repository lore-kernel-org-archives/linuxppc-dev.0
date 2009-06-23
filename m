Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4FB9BB7297
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 23:05:08 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96A27DDDB2
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 23:05:07 +1000 (EST)
Message-Id: <FA8870C8-8F6B-47CA-B6A0-BC36583643A5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Huang Weiyi <weiyi.huang@gmail.com>
In-Reply-To: <1245496619-2784-1-git-send-email-weiyi.huang@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH 4/4] powerpc/85xx: remove duplicated #include
Date: Tue, 23 Jun 2009 08:04:58 -0500
References: <1245496619-2784-1-git-send-email-weiyi.huang@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 20, 2009, at 6:16 AM, Huang Weiyi wrote:

> Remove duplicated #include in arch/powerpc/platforms/85xx/ 
> xes_mpc85xx.c.
>
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
> ---
> arch/powerpc/platforms/85xx/xes_mpc85xx.c |    1 -
> 1 files changed, 0 insertions(+), 1 deletions(-)


applied to next

- k
