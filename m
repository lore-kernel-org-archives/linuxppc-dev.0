Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 67EDAB7B92
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 14:33:40 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BAF01DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 14:33:39 +1000 (EST)
Message-Id: <056AD44A-AC2B-4881-AE8E-91666FF52FC7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20090702141825.22330.83064.stgit@ES-J7S4D2J.amer.consind.ge.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] powerpc/86xx: Update GE Fanuc sbc310 DTS
Date: Wed, 29 Jul 2009 23:33:29 -0500
References: <20090702141825.22330.83064.stgit@ES-J7S4D2J.amer.consind.ge.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 2, 2009, at 9:18 AM, Martyn Welch wrote:

> Update GE Fanuc DTS to match the alterations suggested during the  
> merge of the ppc9a DTS in commit  
> 740d36ae6344f38c4da64c2ede765d7d2dd1f132
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> arch/powerpc/boot/dts/gef_sbc310.dts |   29 ++++++++++++ 
> +----------------
> 1 files changed, 13 insertions(+), 16 deletions(-)

tried to apply this but wasn't able to.. please repost and will defer  
for .32 at this point (and fix the commit message since its a run on,  
guessing that might be related to why I couldn't apply it).

- k
