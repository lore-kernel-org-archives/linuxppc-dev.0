Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1116909351.4992.19.camel@gaston>
References: <1116909286.4992.17.camel@gaston> <1116909351.4992.19.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <78325f65fc807da213be423c20ce6dcd@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 24 May 2005 09:50:30 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc64-dev@ozlabs.org, Tzachi Perelstein <tzachi@marvell.com>,
	u-boot-users@lists.sourceforge.net,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Booting the Linux/ppc64 kernel without Open Firmware HOWTO (v3)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +/*
> + * The Open Firmware 1275 specification states properties must be 31 
> bytes or
> + * less, however not all firmwares obey this. Make it 64 bytes to be 
> safe.
> + */

Not true.  There is no restriction on the length of properties
(or property _names_, which I guess is what you meant).  There
is the 31-char restriction on _node_ names, though (and the node
name is only the part before the optional @ or : -- and at a
minimum, the part after @ but before : is needed to disambiguate
the node).

I didn't review the rest of the code, sorry.


Segher
