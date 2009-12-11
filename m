Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1259208310.16367.231.camel@pasglop>
References: <20091124081316.6216.66310.stgit@angua>
	<20091124081906.6216.67035.stgit@angua>
	<1259208310.16367.231.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Dec 2009 23:54:55 -0700
Message-ID: <fa686aa40912102254u7cd53819q6550d7b2413d0121@mail.gmail.com>
Subject: Re: [PATCH 07/11] of: merge machine_is_compatible()
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

On Wed, Nov 25, 2009 at 9:05 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2009-11-24 at 01:19 -0700, Grant Likely wrote:
>> Merge common code between PowerPC and Microblaze
>
> I don't like moving this one to common code without the of_ prefix. I
> think you should move it with the of_ prefix, and then add a alias in
> powerpc and microblaze without of_ in a header until we fix all call
> sites (which you can put on your to-do list :-)

I've written another patch to rename it.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
