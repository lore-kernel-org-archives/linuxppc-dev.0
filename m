Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 67286DDEDC
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Apr 2008 00:17:27 +1000 (EST)
Message-Id: <3DF1D578-6650-4FA9-B154-EF4666E81F52@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <47FB75BC.10400@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: TSEC3/4 broken on MPC8548?
Date: Tue, 8 Apr 2008 09:17:14 -0500
References: <47FB75BC.10400@grandegger.com>
Cc: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 8, 2008, at 8:40 AM, Wolfgang Grandegger wrote:
> Hello,
>
> in the dts file for the MPC8548CDS the nodes for TSEC3/4 are commented
> out because they seem to be broken:
>
>  $ grep broken arch/powerpc/boot/dts/*
>  arch/powerpc/boot/dts/mpc8548cds.dts:/* eTSEC 3/4 are currently  
> broken
>
> Is it still true?

This was a board issue and not a chip issue.  However I'm not sure if  
the board issues have been resolved.  Hopefully Andy will know.

- k
