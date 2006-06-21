Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20060620174000.GA22159@mag.az.mvista.com>
References: <20060620174000.GA22159@mag.az.mvista.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AAA9913C-E026-4CB5-B835-B736511BAD1B@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: OF setprop question
Date: Wed, 21 Jun 2006 02:11:26 +0200
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> What does OF do when you 'setprop' a property that doesn't already  
> exist?
> Does OF create it?

Yes.

> What if it exists but the new prop requires more space than the old  
> prop?
> Does it make space more space for the new property?

Yes.


Now that was easy :-)

Just out of interest, what in the wording of the OF spec didn't
make this clear to you?  Would be great to improve it ;-)


Segher
