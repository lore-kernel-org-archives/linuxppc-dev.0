Return-Path: <jdl@jdl.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony 
In-Reply-To: Your message of "Thu, 15 Feb 2007 01:27:28 +0100."
	<90e2bb990b7e1f46c6eaccd1d9255d77@kernel.crashing.org>
References: <20070213061026.5837FDDDE9@ozlabs.org>
	<e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org>
	<20070214002210.GE11491@localhost.localdomain>
	<45afe653a3f963e21e58a063c09b1b22@kernel.crashing.org>
	<20070214231734.GC16279@localhost.localdomain>
	<90e2bb990b7e1f46c6eaccd1d9255d77@kernel.crashing.org>
Date: Thu, 15 Feb 2007 08:02:49 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HHhCD-0004Hf-QT@jdl.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Segher Boessenkool mumbled:
> The first option.  Anywhere a number can be used, "d# xxx"
> would mean decimal.
> 
> When you would say <d# 1234  5678>, 1234 is decimal and
> 5678 is hexadecimal.

Where do the tokens end?  Is "d#1234" valid and equal to "d# 1234"?
Or is "d#" an independent token?  And are there other bases to
this model?  Like, maybe, "b#", "o#" and "h#" as well?

jdl
