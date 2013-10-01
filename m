Return-Path: <michael@ellerman.id.au>
Date: Tue, 1 Oct 2013 18:43:44 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH V2] powerpc/kernel/sysfs: disable writing to purr in
 non-powernv
Message-ID: <20131001084344.GE27484@concordia>
References: <1380281634-9921-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20131001063129.GF17966@concordia>
 <1380613830.645.18.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380613830.645.18.camel@pasglop>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 01, 2013 at 05:50:30PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2013-10-01 at 16:31 +1000, Michael Ellerman wrote:
> 
> > > 1)Changed the test for to hypervisor mode instead of platform
> > 
> > I think Ben's wrong about that.
> > 
> > Almost all existing code uses FW_FEATURE_LPAR to differentiate
> > hypervisor vs guest mode, so I think we should do the same here.
> 
> I didn't object to using the FW test, it's a reasonable way to do it, I
> objected to using the platform as an indication (powernv vs. pseries)

Yeah sorry I wasn't clear. You are right that it shouldn't use the
platform. So I think we agree FW_FEATURE is the right way to go.

cheers
