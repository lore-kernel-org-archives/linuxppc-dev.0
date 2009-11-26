Return-Path: <albert_herranz@yahoo.es>
Received: from smtp104.mail.ukl.yahoo.com (smtp104.mail.ukl.yahoo.com
	[77.238.184.36]) by ozlabs.org (Postfix) with SMTP id 019E91007DD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 02:19:22 +1100 (EST)
Message-ID: <4B0E9C78.4000805@yahoo.es>
Date: Thu, 26 Nov 2009 16:19:20 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>	
	<49436.84.105.60.153.1259171377.squirrel@gate.crashing.org>	
	<4B0D78B0.502@yahoo.es> <1259211505.16367.261.camel@pasglop>
In-Reply-To: <1259211505.16367.261.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2009-11-25 at 19:34 +0100, Albert Herranz wrote:
>> We need nobats (or a hack in the mmu_mapin_ram() code) because of the
>> discontiguous ram problem.
> 
> I would vote for a hack in mmu_mapin_ram() for now.
> 

I'll cook that.

> Cheers,
> Ben.
> 

Thanks,
Albert
