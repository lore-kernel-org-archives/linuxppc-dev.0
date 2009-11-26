Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1259207478.16367.218.camel@pasglop>
References: <20091124081316.6216.66310.stgit@angua>
	<20091124081747.6216.88376.stgit@angua>
	<1259207478.16367.218.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 25 Nov 2009 21:02:02 -0700
Message-ID: <fa686aa40911252002w5d09bd8qc8170ba4f61345ae@mail.gmail.com>
Subject: Re: [PATCH 01/11] of/flattree: Merge early_init_dt_check_for_initrd()
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

On Wed, Nov 25, 2009 at 8:51 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2009-11-24 at 01:17 -0700, Grant Likely wrote:
>> Merge common code between PowerPC and Microblaze
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
>> Tested-by: Michal Simek <monstr@monstr.eu>
>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> Remind me how you want to merge that ? via my tree ?

Since it is cross-arch, I'll ask Linus to pull directly.  We'll see if
that takes.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
