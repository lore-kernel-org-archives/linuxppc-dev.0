Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A3A811007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Jul 2010 02:40:07 +1000 (EST)
Message-ID: <4C2CC4E2.2010501@suse.de>
Date: Thu, 01 Jul 2010 18:40:02 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: kvm-ppc@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S_32 MMU debug compile fixes
References: <1277507511-413-1-git-send-email-agraf@suse.de>
In-Reply-To: <1277507511-413-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf wrote:
> Due to previous changes, the Book3S_32 guest MMU code didn't compile properly
> when enabling debugging.
>
> This patch repairs the broken code paths, making it possible to define DEBUG_MMU
> and friends again.
>
> Signed-off-by: Alexander Graf <agraf@suse.de>
>   

Please also don't forget this patch :)


Alex
