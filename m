Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id F1668B7101
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:56:59 +1000 (EST)
Date: Mon, 30 Aug 2010 22:49:32 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/3] PPC: s/mtmsrd/MTMSR in ldstfp.S
Message-ID: <20100830224932.21b5d7f2@lappy.seanm.ca>
In-Reply-To: <1283220922-20369-2-git-send-email-agraf@suse.de>
References: <1283220922-20369-1-git-send-email-agraf@suse.de>
	<1283220922-20369-2-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 31 Aug 2010 04:15:20 +0200
Alexander Graf <agraf@suse.de> wrote:

> Commit 0016a4cf introduced a lot of mtmsrd's that were plainly
> written out. These failed to compile on my e500v2 system, so let's
> better use the macro that is around just for that purpose.

I sent in the same patch ;)

Cheers,
   Sean
