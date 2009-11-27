Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3C5D1B7BBF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 23:02:16 +1100 (EST)
In-Reply-To: <1259209392.16367.242.camel@pasglop>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221502g2de254d2o4341d9abed0cdf41@mail.gmail.com>
	<4B0AE603.9050208@yahoo.es>
	<fa686aa40911231219k3a52b9fdn66b8cffb735e5c2f@mail.gmail.com>
	<1259209392.16367.242.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <500F54EF-18DE-45EE-89EC-1F672C0FF208@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 02/19] powerpc: gamecube: device tree
Date: Fri, 27 Nov 2009 13:09:14 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Similarly, it is better to use a compatible value of something like:
>> compatible = "nintendo,flipper-immr"; (instead of "nintendo,flipper")
>> because your describing just the internal bus, not the entire chip.
>
> I would just call the nodes "flipper" and "hollywood".

Either that, or not have these omnibus nodes at all, they are useless
and do not describe the hardware very well either.


Segher
