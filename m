Return-Path: <dgibson@ozlabs.org>
Date: Thu, 20 Mar 2008 19:20:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?Andr=E9?= Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: simple MPC5200B system
Message-ID: <20080320082035.GA23860@localhost.localdomain>
References: <47DF821B.6090600@matrix-vision.de>
	<20080320001445.C03DD24A8B@gemini.denx.de>
	<20080320002149.GD19616@localhost.localdomain>
	<47E216DA.8080602@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <47E216DA.8080602@matrix-vision.de>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2008 at 08:48:42AM +0100, André Schwarz wrote:
> David Gibson schrieb:
>> On Thu, Mar 20, 2008 at 01:14:45AM +0100, Wolfgang Denk wrote:
>>> In message <47DF821B.6090600@matrix-vision.de> you wrote:
>>>> I've pulled the latest git and built a mpc5200_simple system with a 
>>>> minimal dts.
>>>> There's not a single char put on the console ....
>>> You did build your device tree with "-b 0", didn't you?
>> Ugh.. I really need to fix dtc to pick the default boot cpu value more
>> sensibly, don't I.
>
> I didn't specify "-b 0". This shouldn't be neccessary on a single processor 
> system ! After all it's an option ... "0" should be default.

Should, yes.  But dtc's pretty new, and a sensible default for -b is
one thing that isn't there.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
