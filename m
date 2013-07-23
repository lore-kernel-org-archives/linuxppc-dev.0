Return-Path: <michael@ellerman.id.au>
Date: Wed, 24 Jul 2013 00:06:45 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] cpuidle/powernv: cpuidle backend driver for powernv
Message-ID: <20130723140645.GI31944@concordia>
References: <20130723090111.7291.99479.stgit@deepthi.in.ibm.com>
 <20130723090137.7291.36657.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130723090137.7291.36657.stgit@deepthi.in.ibm.com>
Cc: linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 23, 2013 at 02:31:41PM +0530, Deepthi Dharwar wrote:
> This patch implements a back-end cpuidle driver for
> powernv calling power7_nap and snooze idle states.
> This can be extended by adding more idle states
> in the future to the existing framework.

Other than the state table and a few minor details this looks almost
identical to the pseries driver. Can we not have a single version in
sysdev and isolate just the differences?

cheers
