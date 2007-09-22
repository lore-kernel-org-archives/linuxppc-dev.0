Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18164.40462.991761.909735@cargo.ozlabs.ibm.com>
Date: Sat, 22 Sep 2007 14:46:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: [patch 04/28] Add cmpxchg64 and cmpxchg64_local to powerpc
In-Reply-To: <20070827155524.827591009@polymtl.ca>
References: <20070827155234.062715780@polymtl.ca>
	<20070827155524.827591009@polymtl.ca>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mathieu Desnoyers writes:

> Make sure that at least cmpxchg64_local is available on all architectures to use
> for unsigned long long values.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

Acked-by: Paul Mackerras <paulus@samba.org>
