Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 46A6DDE1C6
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Sep 2008 01:17:19 +1000 (EST)
Message-ID: <48C14D77.4040001@freescale.com>
Date: Fri, 05 Sep 2008 10:17:11 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Beamonte <dbeamonte@telnet-ri.es>
Subject: Re: Host USB issue on MPC8272
References: <48C0DD6F.8070205@telnet-ri.es>
In-Reply-To: <48C0DD6F.8070205@telnet-ri.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

David Beamonte wrote:
> This issue seems to be related to one problem that we have always had. 
> We can't configure buffers of SMCs, SCCs, etc, to be in SDRAM, because 
> the processor hangs. We always have to configure buffers in DPRAM. In 
> other drivers this has not been a problem, because the buffer size is 
> not very large, so we can allocate it in DPRAM, but for this one, the 
> buffer size is 0x8000 (32Kb) which exceeds DPRAM size.
> 
> Has anybody had the same problem? Can it be an USB specific problem or a 
> general one?

Make sure that BCR[PLDP] is not set, as per erratum SIU18.

-Scott
