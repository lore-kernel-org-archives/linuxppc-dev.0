Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18109.1138.869633.593502@cargo.ozlabs.ibm.com>
Date: Sat, 11 Aug 2007 10:36:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Implement atomic{, 64}_{read,
	write}() without volatile
In-Reply-To: <11867913303733-git-send-email-segher@kernel.crashing.org>
References: <11867913303733-git-send-email-segher@kernel.crashing.org>
	<d6775e129db48371cdf86e94ddfaa1d15617bb8f.1186773842.git.segher@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> Instead, use asm() like all other atomic operations already do.
> 
> Also use inline functions instead of macros; this actually
> improves code generation (some code becomes a little smaller,
> probably because of improved alias information -- just a few
> hundred bytes total on a default kernel build, nothing shocking).
> 
> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>

Looks OK to me.  In the hope that Chris Snook will pick it up and
include it with his other atomic changes:

Acked-by: Paul Mackerras <paulus@samba.org>
