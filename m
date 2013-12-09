Return-Path: <michael@ozlabs.org>
In-Reply-To: <1386153162-11225-11-git-send-email-khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 khandual@linux.vnet.ibm.com
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V4 10/10] powerpc,
 perf: Cleanup SW branch filter list look up
Message-Id: <20131209062147.B874D2C00C6@ozlabs.org>
Date: Mon,  9 Dec 2013 17:21:47 +1100 (EST)
Cc: mikey@neuling.org, ak@linux.intel.com, eranian@google.com,
 acme@ghostprotocols.net, sukadev@linux.vnet.ibm.com, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-04-12 at 10:32:42 UTC, Anshuman Khandual wrote:
> This patch adds enumeration for all available SW branch filters
> in powerpc book3s code and also streamlines the look for the
> SW branch filter entries while trying to figure out which all
> branch filters can be supported in SW.

This appears to patch code that was only added in 8/10 ?

Was there any reason not to do it the right way from the beginning?

cheers
