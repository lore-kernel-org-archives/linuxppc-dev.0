Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1259208468.16367.234.camel@pasglop>
References: <20091124081316.6216.66310.stgit@angua>
	<20091124081931.6216.27102.stgit@angua>
	<1259208468.16367.234.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Dec 2009 15:21:47 -0700
Message-ID: <fa686aa40912101421h4eabfeaat7925d89ebfe2c5a0@mail.gmail.com>
Subject: Re: [PATCH 09/11] of: merge of_attach_node() & of_detach_node()
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

On Wed, Nov 25, 2009 at 9:07 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2009-11-24 at 01:19 -0700, Grant Likely wrote:
>> Merge common code between PowerPC and Microblaze
>
> Some of those guys might wnat to be in of_dynamic (see previous email)
>
> Remember: We want to keep the footprint low for embedded archs that
> don't want to do dynamic stuff. Really low.

I agree.  If it is okay by you I'll update this in a subsequent patch.
 Once the code is merge, then I'm going to do a bunch of refactoring
patches.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
