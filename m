Return-Path: <cml3227@eircom.net>
Received: from stanley (unknown [193.120.93.98])
	by ozlabs.org (Postfix) with ESMTP id D07652BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Nov 2004 20:09:17 +1100 (EST)
Received: from [192.168.1.160] (helo=eircom.net)
	by stanley with esmtp (Exim 4.30) id 1CTz3W-0002Gs-27
	for linuxppc-embedded@ozlabs.org; Tue, 16 Nov 2004 08:51:18 +0000
Message-ID: <4199BF85.9030600@eircom.net>
Date: Tue, 16 Nov 2004 08:51:17 +0000
From: Conor McLoughlin <cml3227@eircom.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <OFF3BFC73F.53C5A7DE-ONC1256F4D.00564648-C1256F4D.0058DF9F@axxessit.no>
	<11C15E9E-3765-11D9-A70B-003065F9B7DC@embeddededge.com>
In-Reply-To: <11C15E9E-3765-11D9-A70B-003065F9B7DC@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: MPC82xx -- DPRAM1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:
> 
> On Nov 15, 2004, at 11:10 AM, morten.banzon@axxessit.no wrote:
> 
>> I am using 2.6.9 for a mpc8280 project, and am having trouble using 
>> dpram1
>> from offset zero, which I need for a mcc hdlc driver.
> 
> 
> Why does it have to start at zero?

Because the MCC uses a fixed area of dpram.
MCC1 uses dpram starting at 0.
MCC2 uses dpram starting at 0x2000.

---Conor
