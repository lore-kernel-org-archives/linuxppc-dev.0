Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1259213266.16367.274.camel@pasglop>
References: <20091124081316.6216.66310.stgit@angua>
	<20091124081827.6216.1896.stgit@angua>
	<1259207974.16367.226.camel@pasglop>
	<fa686aa40911252005o2db85dfk3d9acc61c12ca5e5@mail.gmail.com>
	<1259213266.16367.274.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F307E7FB-0819-47E8-9CF4-CA1433C18DA6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 04/11] of/flattree: eliminate cell_t typedef
Date: Thu, 26 Nov 2009 22:36:41 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: sfr@canb.auug.org.au, microblaze-uclinux@itee.uq.edu.au,
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

>> You're right, it's not, but makes merging less complex, and then I  
>> can
>> refactor properly.
>
> Still, make them __be32 at least

There is no alignment guarantee at all either, better make it all u8
and use accessor functions everywhere.


Segher
