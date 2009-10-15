Return-Path: <RFeany@mrv.com>
Received: from bos-spam.mrv.com (mx5.mrv.com [140.179.254.12])
	by ozlabs.org (Postfix) with ESMTP id C8AF2B7B81
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 12:08:58 +1100 (EST)
Date: Wed, 14 Oct 2009 18:08:55 -0700
From: Rex Feany <RFeany@mrv.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: I think I have 8xx working...
Message-ID: <20091015010855.GA32710@compile2.chatsunix.int.mrv.com>
References: <20091015004127.GA15570@laura.chatsunix.int.mrv.com>
	<1255568772.2347.60.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1255568772.2347.60.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thus spake Benjamin Herrenschmidt (benh@kernel.crashing.org):

> On Wed, 2009-10-14 at 17:41 -0700, Rex Feany wrote:
> > The biggest problem for me turned out to be the MMU context IDs being
> > clamped to 32 when the 8xx only has 16. With this, things are a bit more
> > stable :)
> 
> This is with Joakim patches or without ?

with just one: adding tlbil_va() to do_page_fault().

take care!
/rex.
