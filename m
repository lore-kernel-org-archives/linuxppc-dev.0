Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0161.hostedemail.com
 [216.40.44.161])
 by lists.ozlabs.org (Postfix) with ESMTP id 513791A0E1D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 12:57:55 +1100 (AEDT)
Message-ID: <1427767069.14276.42.camel@perches.com>
Subject: Re: [PATCH 06/25] powerpc: Use bool function return values of
 true/false not 1/0
From: Joe Perches <joe@perches.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 30 Mar 2015 18:57:49 -0700
In-Reply-To: <1427766549.20500.108.camel@kernel.crashing.org>
References: <cover.1427759009.git.joe@perches.com>
 <6d45a6e4596f0b282048fc4b8db9e7f7a19a46e3.1427759009.git.joe@perches.com>
 <1427766549.20500.108.camel@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-31 at 12:49 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2015-03-30 at 16:46 -0700, Joe Perches wrote:
> > Use the normal return values for bool functions
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Should we merge it or will you ?

Hey Ben.

I don't merge stuff.  I just send patches.
So, it'll be better if you do it.

I'll resend whatever doesn't get picked up in
the next couple months on to Andrew Morton.

cheers.  Joe
