Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC67F67C33
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Oct 2006 01:54:32 +1000 (EST)
In-Reply-To: <3C02138692C13C4BB675FE7EA24095291F5A15@bluefin.Soneticom.local>
References: <3C02138692C13C4BB675FE7EA24095291F5A15@bluefin.Soneticom.local>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <79F33E1E-6E53-4814-9C09-B591FFB1953E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: GCC version to kernel version
Date: Fri, 13 Oct 2006 10:54:39 -0500
To: "Clint Thomas" <cthomas@Soneticom.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 13, 2006, at 10:39 AM, Clint Thomas wrote:

> I tried building some different cross-tools earlier on today that used
> GCC 3.4.3 and GLIBC 2.3.3 (I believe Kumar, you provided links to  
> these
> in another mailing list) They were from some e500 patches to
> crosstool-0.28, but I decided to just patch crosstool-0.42 since  
> that is
> what is available. They were not able to compile my linux kernel  
> source
> without a build error, so I am running out of ideas. I have been  
> trying
> to build GCC 3.4.1 / GLIBC 2.3.3 by passing it the necessary
> TARGET_CFLAGS="-msoft-float -mno-string -Wa,-me500 -O2" and
> GLIBC_EXTRA_CONFIG="--without-fp", but this is not building correctly
> either. Any advice or recommendations are appreciated.

I'd suggest taking a look at the ltib project as it has prebuilt  
compilers and support for 85xx:

http://savannah.nongnu.org/projects/ltib/
http://www.bitshrine.org/

- k
