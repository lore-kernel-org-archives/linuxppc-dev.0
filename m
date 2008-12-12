Return-Path: <scottwood@freescale.com>
Message-ID: <4942C61E.8090602@freescale.com>
Date: Fri, 12 Dec 2008 14:14:22 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: jeff angielski <jeff@theptrgroup.com>
Subject: Re: 8260 and powerpc with dts
References: <1229109927.829.5.camel@penguin>
In-Reply-To: <1229109927.829.5.camel@penguin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

jeff angielski wrote:
> I am looking to upgrade an old mpc8260 board from 2.4 to 2.6.x and was
> looking for a reference to port against.  However, I cannot find any
> reference to 8260 in the dts files in kernel.org or the DENX kernel.
> 
> Is anybody using the latest 2.6.x with the 8260s?  After the switch to
> the dts implementation?  
> 
> Is the 8260 arch fully supported in powerpc (as opposed to the old ppc)?

There are some 8272 and 8280 boards supported in arch/powerpc 
(mpc8272ads, pq2fads, ep8248e); an 8260 board should be similar.

-Scott
