Return-Path: <agust@denx.de>
Date: Tue, 20 Mar 2012 17:20:06 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/5] powerpc/5200: convert mpc5200 to use
 of_platform_populate()
Message-ID: <20120320172006.42f6fb42@wker>
In-Reply-To: <20110621184513.18176.24174.stgit@ponder>
References: <20110621181127.18176.1384.stgit@ponder>
 <20110621184513.18176.24174.stgit@ponder>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Jun 2011 12:45:13 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> of_platform_populate() also handles nodes at the root of the tree,
> which is wanted for things like describing the sound complex.  This
> patch converts mpc5200 support to use of_platform_populate() instead
> of of_platform_bus_probe().
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  arch/powerpc/platforms/52xx/mpc52xx_common.c |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)

Applied for mpc5xxx next, thanks.

Anatolij
