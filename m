Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14355B6F1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 09:16:40 +1100 (EST)
In-Reply-To: <1259210142.16367.248.camel@pasglop>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<CE435D2F-8C67-4045-942D-4AA08BF784D0@kernel.crashing.org>
	<4B0C1A25.8030401@yahoo.es> <1259210142.16367.248.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ABC1BC5A-99F8-4B0A-8252-A9AB51FC4C7D@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 03/19] powerpc: gamecube: bootwrapper bits
Date: Thu, 26 Nov 2009 23:23:36 +0100
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

>> So what's your proposal then? Placing it within a fake func?
>
> Just do a .S file :-)

Yeah.  You might be able to do one that handles both GC and Wii,
maybe it's easier/clearer to keep them separate though.

> Ouch. I wouldn't be surprised if those guys don't do cache coherency
> in the bridge anyways.

That is correct; we haven't found any way to enable it, at least.
To be fair, it's actually better for performance to _not_ do RAM
coherency when used as a game system.


Segher
