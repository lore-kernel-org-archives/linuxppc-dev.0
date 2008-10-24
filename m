Return-Path: <dgibson@ozlabs.org>
Date: Fri, 24 Oct 2008 14:27:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Mitch Bradley <wmb@firmworks.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
Message-ID: <20081024032739.GD4267@yookeroo.seuss>
References: <4900ED81.3040202@genesi-usa.com> <4900F90B.80703@firmworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4900F90B.80703@firmworks.com>
Cc: devicetree-discuss list <devicetree-discuss@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 23, 2008 at 12:22:03PM -1000, Mitch Bradley wrote:
> You could have the gpio node define an "address space" where each  
> "address" is a GPIO pin number.
>
> The node would have one address cell and one size cell, and the  

Not necessarily.  If you were to have such an address space, the only
sane way of encoding it would be using the same "gpio descriptor"
format as is used in 'gpios' properties.  Which would mean the gpio
controller would in this situation have #address-cells == #gpio-cells.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
