Return-Path: <wmb@firmworks.com>
Message-ID: <4B0E33C3.1020803@firmworks.com>
Date: Wed, 25 Nov 2009 21:52:35 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 04/11] of/flattree: eliminate cell_t typedef
References: <20091124081827.6216.1896.stgit@angua>	<1259207974.16367.226.camel@pasglop>	<fa686aa40911252005o2db85dfk3d9acc61c12ca5e5@mail.gmail.com>	<20091125.232818.-1350498258.imp@bsdimp.com>
	<1259219171.16367.331.camel@pasglop>
In-Reply-To: <1259219171.16367.331.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: sfr@canb.auug.org.au, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
	"M. Warner Losh" <imp@bsdimp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> Right, that's the only sane way to do it, I just didn't remember off
> hand what was said in the OF spec  :-) 


3.2.2.1.2 Property values

The property-encoding format is independent of hardware byte order and 
alignment characteristics.  The encoded byte order is well-defined (in 
particular, it is big endian). ...

...

-- 32-bit integer.  A 32-bit integer is encoded into a property value 
byte array by storing the most significant byte at the next available 
address, followed (at address+1) by the high middle byte, the low middle 
byte, and (at address+3) the least significant byte.
