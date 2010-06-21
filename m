Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1276151887.1962.53.camel@pasglop>
References: <20100604212134.10552.70717.stgit@angua>
	<20100604212145.10552.95452.stgit@angua>
	<1276151887.1962.53.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 21 Jun 2010 15:11:28 -0600
Message-ID: <AANLkTimW92nSwxqo_Pbrm1KR2rmagHigaLTBEJipmZIU@mail.gmail.com>
Subject: Re: [PATCH 3/5] of/irq: merge of_irq_find_parent()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Simek <monstr@monstr.eu>,
	linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 10, 2010 at 12:38 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2010-06-04 at 15:21 -0600, Grant Likely wrote:
>> Merge common code between PowerPC and Microblaze. =A0Also create a new
>> arch hook, of_irq_find_parent_by_phandle() to handle arch-specific
>> quirks.
>
> First, you changeset comment should be much more verbose as to
> what that arch specific quirk is about etc... it took me time to figure
> it out again :-)
>
> I dislike the naming you use. Your "of_irq_find_parent_by_phandle"
> doesn't ring "right" to me.
>
> I'm tempted to say we should put the quirks in the common code, your
> attempt at "abstracting" them just makes the code much harder to follow.
>
> Also, if we stick to your approach the "default" variant should either
> be an inline protected by an ifndef or a weak function.

Alright, I've rewritten all the IRQ changes and I've left the quirk
handling in common code, while moving the powermac quirk code into
arch/powerpc/platforms/powermac.  I'll repost today.

g.
