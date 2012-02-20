Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH] params: Fix parse_args() use in PowerPC's
 reserve_hugetlb_gpages()
In-Reply-To: <1329494916-20575-1-git-send-email-pawel.moll@arm.com>
References: <20120216111513.918494b07a5331eabe3d32ac@canb.auug.org.au>
 <1329494916-20575-1-git-send-email-pawel.moll@arm.com>
Date: Mon, 20 Feb 2012 11:56:13 +1030
Message-ID: <87aa4e8fd6.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Neuling <mikey@neuling.org>, Pawel Moll <pawel.moll@arm.com>,
 linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
 McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 17 Feb 2012 16:08:36 +0000, Pawel Moll <pawel.moll@arm.com> wrote:
> Commit b8076966e8e1 ("params: <level>_initcall-like kernel parameters")
> changed the parse_args() API without fixing all the callers. Done now.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Thanks Stephen, Pawel.

Applied,
Rusty.
