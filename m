Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1259207655.16367.220.camel@pasglop>
References: <20091124081316.6216.66310.stgit@angua>
	<20091124081800.6216.27311.stgit@angua>
	<1259207655.16367.220.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 25 Nov 2009 21:03:23 -0700
Message-ID: <fa686aa40911252003i7534599egae235e1d115c7213@mail.gmail.com>
Subject: Re: [PATCH 02/11] of/flattree: Merge earlyinit_dt_scan_root()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 25, 2009 at 8:54 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2009-11-24 at 01:18 -0700, Grant Likely wrote:
>> Merge common code between PowerPC and Microblaze
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>
> Ok with that, like the precendent, however you are making global some
> symbols that were previously static which sucks a bit... But then they
> can be made static again I suppose once more has been merged.

exactly.  My plan is: 1) merge.  2) refactor (and make things static
again)  3) port to ARM  4) ????  5) profit.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
