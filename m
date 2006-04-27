Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA0E367A41
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Apr 2006 02:16:26 +1000 (EST)
In-Reply-To: <20060427160755.24553.qmail@web37812.mail.mud.yahoo.com>
References: <20060427160755.24553.qmail@web37812.mail.mud.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A06A1A67-A662-470E-A5D1-B59A233CBA0D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: u-boot.bin
Date: Thu, 27 Apr 2006 11:16:18 -0500
To: Eric Heim <sheldoninstruments@yahoo.com>
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


On Apr 27, 2006, at 11:07 AM, Eric Heim wrote:

> Sorry if this may seem basic to some but is there anything I need  
> to know about the format of the u-boot.bin?  I want to write a  
> program to burn the flash on the MPC8349 via the PCI interface.   
> Just not sure where to get info on binary file format and if there  
> is anything unique about the binary created from u-boot.

This question is best asked on the u-boot lists.  But the u-boot.bin  
is a straight binary file.  The contents should be placed directly  
into the location of flash that you desire.

- kumar
