Return-Path: <michael@ellerman.id.au>
Date: Fri, 22 Mar 2013 15:21:59 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] powerpc: drop even more unused Kconfig symbols
Message-ID: <20130322042159.GC26908@concordia>
References: <1363864206.1390.117.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363864206.1390.117.camel@x61.thuisdomein>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 21, 2013 at 12:10:06PM +0100, Paul Bolle wrote:
> When I submitted commit 6805ab6daa2b589fe3242d05ddc47a9dbb0c4eb1
> ("powerpc: drop unused Kconfig symbols") I apparently failed to notice
> that my patch also made PREP_RESIDUAL and PPC_A2_DD2 unused. Drop these
> now.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) Untested.
> 
> 1) I investigated these Kconfig files a bit and discovered that PPC_PREP
> is marked BROKEN since v2.6.15, see commit
> 5be396b00ca0f2f769c55cf69bbd7c77451c925e ("powerpc: Mark PREP and
> embedded as broken for now"). Though it's not my problem, this does
> suggest PReP support can be removed entirely.

It does, and the best code is deleted code.

Care to send a patch?

cheers
