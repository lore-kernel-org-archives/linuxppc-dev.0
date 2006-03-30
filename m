Return-Path: <tnt@246tNt.com>
Received: from outmx016.isp.belgacom.be (outmx016.isp.belgacom.be
	[195.238.4.115])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CAC9667A00
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Mar 2006 17:37:58 +1100 (EST)
Received: from outmx016.isp.belgacom.be (localhost [127.0.0.1])
	by outmx016.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k2U6bceI013870
	for <linuxppc-embedded@ozlabs.org>; Thu, 30 Mar 2006 08:37:39 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <442B7C8A.5050600@246tNt.com>
Date: Thu, 30 Mar 2006 08:36:58 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Kernel for MPC Lite 5200 will not compile
References: <20060330003419.3FF71353A37@atlas.denx.de>
In-Reply-To: <20060330003419.3FF71353A37@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1
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

Wolfgang Denk wrote:
> In message <442B11E8.7020107@246tNt.com> you wrote:
>   
>> It is ?
>>     
>
> I think so.
>   
The stock 2.6.15 doesn't have bestcomm.

>   
>> I don't know about the 2.6-denx, but the stock 2.6.15 should work just fine.
>> What's wrong with it ? (except it misses some drivers ... it should compile
>> and boot just fine)
>>     
>
> Isn't the current reengineered implementation of  the  BestComm  code
> based  on  an very old Freescale version, which has known limitations
> and problems?
>
> Or has there any action resulted  out  of  the  discussion  with  the
> Freescale engineers, and I have missed it?
>   
The microcode is updated each time I get a new copy from Freescale and the
last time I checked it was up to date is when John Rigby sent me a copy
of the
latest one.
Freescale doesn't change the software interface of the microcode tasks that
much so upgrading isn't that hard.


Regards,

    Sylvain
