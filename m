Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18116.61246.856760.243185@cargo.ozlabs.ibm.com>
Date: Fri, 17 Aug 2007 10:43:42 +1000
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

> +static __inline__ long atomic64_read(const atomic_t *v)

> +static __inline__ void atomic64_set(atomic_t *v, long i)

s/atomic_t/atomic64_t/ in both lines.  I've edited my copy of the patch.

Paul.
