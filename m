Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcCW36QnhzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 19:24:15 +1100 (AEDT)
Date: Mon, 6 Mar 2017 02:24:06 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: pc@us.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc: A new cache geometry aux vectors
Message-ID: <20170306082405.GQ31469@gate.crashing.org>
References: <1486016558.4850.30.camel@kernel.crashing.org>
 <67e56596-05a7-5f3d-8125-a4e0194f1b7c@us.ibm.com>
 <877f48kx0q.fsf@concordia.ellerman.id.au>
 <3d15baac-1705-a1a6-d0b0-1d7f378509d6@us.ibm.com>
 <87fuivhuub.fsf@concordia.ellerman.id.au>
 <288deec2-a821-316b-5e53-e186deda96f9@us.ibm.com>
 <87r32bot2x.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87r32bot2x.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 06, 2017 at 04:46:46PM +1100, Michael Ellerman wrote:
> Hmm, which p9 mambo is this? I get:
> 
> test: cache_shape
> tags: git_version:v4.10-10927-g0a55d1671c33
> L1I  cache size:     0x8000      32768B         32K
> L1I  line size:        0x80       128-way associative
> L1D  cache size:     0x8000      32768B         32K
> L1D  line size:        0x80       128-way associative
> L2   cache size:          0          0B          0K
> L2   line size:           0       fully associative
> L3   cache size:          0          0B          0K
> L3   line size:           0       fully associative
> success: cache_shape
> 
> So that looks OK, other than that here is no L2/L3 info.

128 ways?  Looks okay?  Erm...


Segher
