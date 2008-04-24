Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A279CDE3B6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Apr 2008 02:45:54 +1000 (EST)
Message-Id: <E3E7D3B5-A435-4738-96C1-53B1C3CBB7E5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Brian Silverman <bsilverman@conceptxdesign.com>
In-Reply-To: <4810B196.7000300@conceptxdesign.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: EABI
Date: Thu, 24 Apr 2008 11:45:43 -0500
References: <4810B196.7000300@conceptxdesign.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 24, 2008, at 11:13 AM, Brian Silverman wrote:
> Is it possible to compile a Linux application using an EABI compiler  
> (specfically, Xilinx's EDK powerpc-eabi-gcc.exe)?
>
> The issue at hand is that we'd like for our customers to be able to  
> use the Xilinx EDK toolchain (which we know they will have) to  
> compile Linx apps without having to install another toolchain  
> (crosstool, ELDK, etc).
>
> So, what I'm hoping is that the EDK toolchain can be configured to  
> be Linux compatible binaries, or that there is some kind of wrapper  
> that will handle the incompatible interfaces.  Searching around,  
> I've seen some mention of Linux EABI compatibility (for Debian ARM  
> releases), but I haven't found any clear concensus...
>
> P.S. My apologies if this message appears on the mailing list twice...

The EABI and Linux ABI are not compatible and if you want to link with  
any libraries you will need a different compiler for linux.

- k
