Return-Path: <paulus@ozlabs.org>
Date: Wed, 31 Oct 2012 15:18:34 +1100
From: Paul Mackerras <paulus@samba.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/perf: Add missing L2 constraint handling in
 Power7 PMU
Message-ID: <20121031041834.GE10293@drongo>
References: <1351649396-31639-1-git-send-email-michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351649396-31639-1-git-send-email-michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 31, 2012 at 01:09:56PM +1100, Michael Ellerman wrote:
> If we have two cache events that require different settings of the L2SEL
> bits in MMCR1 then we can not schedule those events simultaneously. Add
> logic to the constraint handling to express that.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Paul Mackerras <paulus@samba.org>
