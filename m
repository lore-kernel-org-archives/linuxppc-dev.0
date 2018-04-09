Return-Path: <benh@kernel.crashing.org>
Message-ID: <1523262156.11062.14.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 4/9] powerpc/powernv: OPAL console standardise
 OPAL_BUSY loops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, skiboot@lists.ozlabs.org
Date: Mon, 09 Apr 2018 18:22:36 +1000
In-Reply-To: <20180409161342.02f41b8a@roar.ozlabs.ibm.com>
References: <20180409052431.26405-1-npiggin@gmail.com>
 <20180409052431.26405-5-npiggin@gmail.com>
 <1523253213.11062.7.camel@kernel.crashing.org>
 <20180409161342.02f41b8a@roar.ozlabs.ibm.com>
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

On Mon, 2018-04-09 at 16:13 +1000, Nicholas Piggin wrote:
> We can always make exceptions to the standard form, but in those
> cases I would like to document it in the OPAL API and comment for
> the Linux side.
> 
> My thinking in this case is that it reduces time in firmware and
> in particular holding console locks. Is it likely / possible that
> we don't have enough buffering or some other issue makes it worth
> retrying so quickly?

Not sure to be honest, but yeah limiting the lock contention inside
OPAL is probably not a bad idea.

Cheers,
Ben.
