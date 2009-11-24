Return-Path: <albert_herranz@yahoo.es>
Received: from smtp122.mail.ukl.yahoo.com (smtp122.mail.ukl.yahoo.com
	[77.238.184.53]) by ozlabs.org (Postfix) with SMTP id D47B21007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 05:03:48 +1100 (EST)
Message-ID: <4B0C2002.4050704@yahoo.es>
Date: Tue, 24 Nov 2009 19:03:46 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 06/19] powerpc: gamecube/wii: introduce GAMECUBE_COMMON
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<3D2BF5CA-C4BE-4250-8EC9-7A8E767572E2@kernel.crashing.org>
In-Reply-To: <3D2BF5CA-C4BE-4250-8EC9-7A8E767572E2@kernel.crashing.org>
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
>> Add a config option GAMECUBE_COMMON to be used as a dependency for all
>> options common to the Nintendo GameCube and Wii video game consoles.
> 
> Maybe something like GAMECUBE_OR_WII instead?  "COMMON" is so
> common it's meaningless.
> 

I don't like either GAMECUBE_OR_WII.
It looks as if it can be used to match options for the GAMECUBE _or_ WII. But that's not the meaning of it.

This option should be used only for options applicable to both the GAMECUBE and WII, i.e. basically those options in the WII which where "inherited" from the GAMECUBE to make it retro-compatible.

If GAMECUBE_COMMON is unacceptable, maybe GAMECUBE_LEGACY or GAMECUBE_COMPAT?

Thanks,
Albert
