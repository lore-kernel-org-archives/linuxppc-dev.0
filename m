Return-Path: <benh@kernel.crashing.org>
Message-ID: <1505355889.12628.177.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 2/2] powerpc/powernv: implement NMI IPIs with
 OPAL_SIGNAL_SYSTEM_RESET
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 skiboot@lists.ozlabs.org
Cc: Alistair Popple <alistair@popple.id.au>
Date: Thu, 14 Sep 2017 12:24:49 +1000
In-Reply-To: <20170913231354.6b249fd0@roar.ozlabs.ibm.com>
References: <20170912160553.13422-1-npiggin@gmail.com>
 <20170912160553.13422-3-npiggin@gmail.com>
 <20170913231354.6b249fd0@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-09-13 at 23:13 +1000, Nicholas Piggin wrote:
> On Wed, 13 Sep 2017 02:05:53 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
> 
> > There are two complications. The first is that sreset from stop states
> > come in with SRR1 set to do a powersave wakeup, with an sreset reason
> > encoded.
> > 
> > The second is that threads on the same core can't be signalled directly
> > so we must designate a bounce CPU to reflect the IPI back.
> 
> Here is an updated Linux patch for the latest OPAL patch. This has
> a few assorted fixes as well to make it work nicely, I roll them into
> one patch here to make it easy to apply for testing the OPAL patch.

Why can't you sreset threads of the same core on P9 ?

Cheers,
Ben.
