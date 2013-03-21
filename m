Return-Path: <lethal@linux-sh.org>
Received: from linux-sh.org (linux-sh.org [111.68.239.195])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E89152C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 20:35:32 +1100 (EST)
Date: Thu, 21 Mar 2013 18:34:55 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] memblock: kill "config MAX_ACTIVE_REGIONS"
Message-ID: <20130321093455.GA8027@linux-sh.org>
References: <1363858076.1390.104.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363858076.1390.104.camel@x61.thuisdomein>
Cc: James Hogan <james.hogan@imgtec.com>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Tejun Heo <tj@kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 21, 2013 at 10:27:56AM +0100, Paul Bolle wrote:
> The Kconfig symbol MAX_ACTIVE_REGIONS is unused. Commit
> 0ee332c1451869963626bf9cac88f165a90990e1 ("memblock: Kill
> early_node_map[]") removed the only place were it was actually used. But
> it did not remove its Kconfig entries (for powerpc and sh).
> 
> Remove those two entries (and the entry for metag, that popped up in
> v3.9-rc1).
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) Eyeball tested again.
> 
> 1) It felt silly to split this clean up patch into three patches. But if
> the maintainers involved disagree I'm happy to split and resend it. 
> 
Given that it's unused now it doesn't really matter how it gets applied,
it looks fine to me.

Acked-by: Paul Mundt <lethal@linux-sh.org>
