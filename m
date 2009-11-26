Return-Path: <albert_herranz@yahoo.es>
Received: from smtp139.mail.ukl.yahoo.com (smtp139.mail.ukl.yahoo.com
	[77.238.184.70]) by ozlabs.org (Postfix) with SMTP id E889CB6F1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 09:07:27 +1100 (EST)
Message-ID: <4B0EFC1D.5030806@yahoo.es>
Date: Thu, 26 Nov 2009 23:07:25 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 12/19] powerpc: gamecube: platform support
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<F5450BB0-FBBB-48D5-A054-CB147FD43EAA@kernel.crashing.org>
	<4B0D6837.4020407@yahoo.es>
	<76CF44C1-3CC1-43B5-958D-E1A7984A44A9@kernel.crashing.org>
In-Reply-To: <76CF44C1-3CC1-43B5-958D-E1A7984A44A9@kernel.crashing.org>
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

Segher Boessenkool wrote:
>> We need it as it currently doesn't match with the default bus ids.
> 
>> Should I introduce a .type property matching any of those above in the
>> soc node, and get rid of the explicit bus probe?
> 
> You don't need any fake bus as far as I can see, just probe the devices
> you want.
> 

But it's way easier to let the bus probe do it for us. I don't see the win here.

> 
> Segher
> 
> 

Thanks,
Albert
