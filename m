Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id A0F5FDDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 11:58:42 +1100 (EST)
Date: Mon, 27 Oct 2008 20:58:38 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Work around ld bug in older binutils
Message-ID: <20081027205838.5f1fcbff@lappy.seanm.ca>
In-Reply-To: <18688.257.812926.680480@drongo.ozlabs.ibm.com>
References: <18688.257.812926.680480@drongo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 23 Oct 2008 15:43:45 +1100
Paul Mackerras <paulus@samba.org> wrote:

> Commit 549e8152de8039506f69c677a4546e5427aa6ae7 ("powerpc: Make the
> 64-bit kernel as a position-independent executable") added lines to
> vmlinux.lds.S to add the extra sections needed to implement a
> relocatable kernel.  However, those lines seem to trigger a bug in
> older versions of GNU ld (such as 2.16.1) when building a
> non-relocatable kernel.  Since ld 2.16.1 is still a popular choice for
> cross-toolchains, this adds an #ifdef to vmlinux.lds.S so the added
> lines are only included when building a relocatable kernel.

I'd like to try this. I did a git revert to back out the aforementioned
commit. How do I get it back? Do I git revert again?

Cheers,
   Sean
