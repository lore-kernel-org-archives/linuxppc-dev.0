Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6B1D267C51
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Aug 2006 02:14:00 +1000 (EST)
Message-ID: <44EF0B11.8020101@cambridgebroadband.com>
Date: Fri, 25 Aug 2006 15:37:05 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Subject: Re: m8260_cpm_dpalloc -> m8260_cpm_dpfree ?
References: <20060825121947.88490@gmx.net>
	<44EF0A61.3050205@cambridgebroadband.com>
In-Reply-To: <44EF0A61.3050205@cambridgebroadband.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Keinen Namen <GSM909@gmx.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Alex Zeffertt wrote:
> Keinen Namen wrote:
>> Hi
>>
>> Simple Question, I allocate Memory for my BDs with m8260_cpm_dpalloc, 
>> but there are no dpfree in Linux 2.4.25. In Linux 2.6 are a funktion 
>> to free dp memory.
>>
>> Are there no funktion in Linux 2.4 ?
> 
> I've implemented the free function for my own benefit.  See attached patch
> which should work against ELDK 3.1
> 

On the other hand I may have just ported it from somewhere else.  I can't remember
now, but anyway it works for me.

Alex
