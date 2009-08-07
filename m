Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 59403B6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 12:38:10 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B05E8DDD01
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 12:38:09 +1000 (EST)
Message-Id: <B8CD6A65-59B6-402E-97DC-8A29929585A2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20090730080651.27000.18194.stgit@ES-J7S4D2J.amer.consind.ge.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH v2] powerpc/86xx: Update GE Fanuc sbc310 DTS
Date: Thu, 6 Aug 2009 21:38:00 -0500
References: <20090730080651.27000.18194.stgit@ES-J7S4D2J.amer.consind.ge.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 30, 2009, at 3:13 AM, Martyn Welch wrote:

> Update GE Fanuc DTS to match the alterations suggested during the  
> merge of
> the ppc9a DTS in commit 740d36ae6344f38c4da64c2ede765d7d2dd1f132
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> v2: Fixed run on message.
>
> Kumar: I think the problem may be that this patch depends on a  
> previous patch:
>
> http://patchwork.ozlabs.org/patch/29335/
>
> Martyn
>
> arch/powerpc/boot/dts/gef_sbc310.dts |   29 ++++++++++++ 
> +----------------
> 1 files changed, 13 insertions(+), 16 deletions(-)

applied to next

For some reason in my tree the extra line at the end had already been  
removed.

- k
