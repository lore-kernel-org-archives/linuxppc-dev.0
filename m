Return-Path: <davem@davemloft.net>
Date: Thu, 26 Nov 2009 15:32:12 -0800 (PST)
Message-Id: <20091126.153212.142866981.davem@davemloft.net>
To: segher@kernel.crashing.org
Subject: Re: [PATCH 04/11] of/flattree: eliminate cell_t typedef
From: David Miller <davem@davemloft.net>
In-Reply-To: <F307E7FB-0819-47E8-9CF4-CA1433C18DA6@kernel.crashing.org>
References: <fa686aa40911252005o2db85dfk3d9acc61c12ca5e5@mail.gmail.com>
	<1259213266.16367.274.camel@pasglop>
	<F307E7FB-0819-47E8-9CF4-CA1433C18DA6@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Thu, 26 Nov 2009 22:36:41 +0100

>>> You're right, it's not, but makes merging less complex, and then I can
>>> refactor properly.
>>
>> Still, make them __be32 at least
> 
> There is no alignment guarantee at all either, better make it all u8
> and use accessor functions everywhere.

I think that might be overkill.
