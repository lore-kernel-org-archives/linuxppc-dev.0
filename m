Return-Path: <B29882@freescale.com>
Received: from CH1EHSOBE003.bigfish.com (ch1ehsobe001.messaging.microsoft.com
	[216.32.181.181]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97979B6F73
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jun 2011 02:01:44 +1000 (EST)
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>
Subject: Re: Mapping an executable page
Date: Tue, 31 May 2011 16:01:35 +0000
Message-ID: <BANLkTinL-z6AUGn-vnDpsWF9bqPenoQ-7w@mail.gmail.com>
References: <BANLkTikd3ZtNRcz=ZWSsDL9OoeV0Wndy1g@mail.gmail.com>
In-Reply-To: <BANLkTikd3ZtNRcz=ZWSsDL9OoeV0Wndy1g@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 27, 2011 at 8:25 AM, Thomas De Schampheleire
<patrickdepinguin+linuxppc@gmail.com> wrote:
> Although I realize that what I need to achieve is unconventional, what
> is the correct way of mapping a certain address range into memory, and
> be able to execute from it?

Can you look at using mpic_reset_core in arch/powerpc/sysdev/mpic.c?
kexec on 85xx uses this to reset other cores the the hold off spin
loop.

-M=
