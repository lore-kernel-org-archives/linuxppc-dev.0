Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20071223034046.GC10699@localhost.localdomain>
References: <20071221202824.GA4607@localhost.localdomain>
	<20071221203115.GA4633@localhost.localdomain>
	<b632798b4f5523653160b6a7156266e1@kernel.crashing.org>
	<20071223034046.GC10699@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b0c0f1d974b3bb081f41109ae2a23a76@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] [POWERPC] Implement GPIO API embryo
Date: Sun, 23 Dec 2007 11:00:26 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I think part of what's happening here is due to the patch's history.

That doesn't make it right though ;-)

> Obviously a
> driver for a particular gpio controller would generally need to assert
> that the controller's #gpio-cells has the correct value for this
> controller type, after which code like the above would be acceptable.

Well to nitpick...  _a_ correct value.  But sure, if this is device-
specific code, it is okay.  OTOH, this really should be a helper
function that each GPIO controller driver can use.


Segher
