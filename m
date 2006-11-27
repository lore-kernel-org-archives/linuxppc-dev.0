Return-Path: <jeff@mock.com>
Received: from mail.mock.com (gw.mock.com [209.157.146.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.mock.com", Issuer "CAcert Class 3 Root" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 66A3967B89
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Nov 2006 04:39:10 +1100 (EST)
Message-ID: <456B22BB.7060301@mock.com>
Date: Mon, 27 Nov 2006 09:39:07 -0800
From: Jeff Mock <jeff@mock.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: PPC440GX ethernet oddities
References: <20061127071454.93C73353A44@atlas.denx.de>
In-Reply-To: <20061127071454.93C73353A44@atlas.denx.de>
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
> In message <456A641D.7070904@mock.com> you wrote:
>> Here's the weird part.  On one of the four prototype boxes, if I plug
>> the second ethernet port into gigabit switch and get a link light (2nd
>> interface is not enabled under linux), the DMA behavior will change and
>> I can see the ring buffer get as large as 25MB (up from 512kB!)
>>
>> Only one of my four boxes shows this strange behavior, and only when the
>> second ethernet port is connected to an ethernet switch. Everything
> 
> Are you using exactly the same switch,  and  the  same  port  on  the
> switch, and the same network cable with all of your boxen?
> 

Yeah, I'm using the same switch, cables, and server machines for these
tests.  I've done quite a lot of fiddling with servers, cables, and
switches looking for some differential behavior, but the only thing I
find is that with second ethernet port unconnected, my ring buffer will
consistently only fill to 512kB, but with the second ethernet port
connect to get a link light (disabled under linux), the ring buffer will
get as full as 25MB over time.

jeff
