Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 37F701007D8
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 01:58:11 +1100 (EST)
Date: Thu, 5 Nov 2009 17:58:09 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/2] Setting GPIOs simultaneously
Message-ID: <20091105145809.GA24319@oksana.dev.rtsoft.ru>
References: <20090713151911.GA28114@oksana.dev.rtsoft.ru>
	<AB7471E8-F924-418B-83A3-2DC48CC707CA@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AB7471E8-F924-418B-83A3-2DC48CC707CA@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 05, 2009 at 08:49:38AM -0600, Kumar Gala wrote:
> 
> On Jul 13, 2009, at 10:19 AM, Anton Vorontsov wrote:
> 
> >Hi all,
> >
> >I've been sitting on these patches for some time, but now it appears
> >that the set_sync() feature is needed elsewhere. So here are the
> >patches.
> >
> >Joakim, I think this is what you need.
> >
> >Thanks,
> 
> What this resolved or dropped?

That was something like an RFC. There are no mainline users for
this support (yet), so we can drop it for now.

Thanks,

p.s.

As David didn't comment on the patches, I'd assume there are no
strong objections against this feature if we'll want to mainline
the support in future. ;-)

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
