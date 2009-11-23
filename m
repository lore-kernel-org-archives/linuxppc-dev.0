Return-Path: <albert_herranz@yahoo.es>
Received: from smtp107.mail.ukl.yahoo.com (smtp107.mail.ukl.yahoo.com
	[77.238.184.39]) by ozlabs.org (Postfix) with SMTP id 395351007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 07:25:24 +1100 (EST)
Message-ID: <4B0AEFB3.7090801@yahoo.es>
Date: Mon, 23 Nov 2009 21:25:23 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 02/19] powerpc: gamecube: device tree
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221502g2de254d2o4341d9abed0cdf41@mail.gmail.com>
	<4B0AE603.9050208@yahoo.es>
	<fa686aa40911231219k3a52b9fdn66b8cffb735e5c2f@mail.gmail.com>
In-Reply-To: <fa686aa40911231219k3a52b9fdn66b8cffb735e5c2f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Mon, Nov 23, 2009 at 12:44 PM, Albert Herranz
>> Can you please elaborate more on this or point me to documentation?
>> The soc node here tries to represent the big multi-function chip that integrates most of the devices of the video game consoles ("Flipper" on the Nintendo GameCube and "Hollywood" on the Wii).
> 
> Right.  Much like many other SoCs.  However, the SoC has all these
> devices + the cpu core + the memory controller, and probably some
> other stuff.  Whereas this particular node only encapsulates the
> integrated peripherals on an internal bus, so the node really is
> describing the internal bus, not the entire SoC.  On some chips it is
> documented as the "internally memory mapped registers", or IMMR.  So,
> it is better to name this node in a way that reflects what it is (an
> internal bus) instead of as the whole chip.
> 
> Similarly, it is better to use a compatible value of something like:
> compatible = "nintendo,flipper-immr"; (instead of "nintendo,flipper")
> because your describing just the internal bus, not the entire chip.
> 
> g.
> 

Thanks for the clarification.
I'll see what I can do :)

Cheers,
Albert
