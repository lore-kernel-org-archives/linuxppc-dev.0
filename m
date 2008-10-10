Return-Path: <benh@kernel.crashing.org>
Subject: Re: Get USE_STRICT_MM_TYPECHECKS working again
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20080909050447.GC30127@yookeroo.seuss>
References: <20080909050447.GC30127@yookeroo.seuss>
Content-Type: text/plain
Date: Fri, 10 Oct 2008 15:31:05 +1100
Message-Id: <1223613065.8157.148.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-09-09 at 15:04 +1000, David Gibson wrote:
> The typesafe version of the powerpc pagetable handling (with
> USE_STRICT_MM_TYPECHECKS defined) has bitrotted again.  This patch
> makes a bunch of small fixes to get it building again.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Doesn't seem to apply anymore, care to rebase ? :-)

Cheers,
Ben.
