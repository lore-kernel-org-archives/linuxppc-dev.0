Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A7358DE071
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Oct 2007 02:42:36 +1000 (EST)
Message-ID: <470E5241.9050606@scram.de>
Date: Thu, 11 Oct 2007 18:41:37 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: Fwd: [PATCH#2 3/4] [PPC] Compile fix for 8xx CPM Ehernet driver
References: <46F7F0B7.2090205@scram.de>	<7F0D5001-BDDC-48A3-A414-2D3C1CE1574B@kernel.crashing.org>
	<46FD1FF0.7020607@garzik.org>
In-Reply-To: <46FD1FF0.7020607@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev <netdev@vger.kernel.org>,
	"linux-ppc-embedded \(\(\(\(E-Mail\)\)\)\)" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jeff,

> Kumar Gala wrote:
>   
>> Begin forwarded message:
>>
>>     
>>> From: Jochen Friedrich <jochen@scram.de>
>>> Date: September 24, 2007 12:15:35 PM CDT
>>> To: linuxppc-embedded@ozlabs.org
>>> Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>
>>> Subject: [PATCH#2 3/4] [PPC] Compile fix for 8xx CPM Ehernet driver
>>>       
>> Jeff,
>>
>> Please pick up for 2.6.23 if you don't mind.
>>     
>
> Please send an apply-able patch...
>
> 	Jeff, off to bed
>   

I rebased git://git.bocc.de/dbox2.git ppc-fixes against 2.6.23. This 
patch is the only remaining one in this head.
I'll resend.

Thanks,
Jochen
