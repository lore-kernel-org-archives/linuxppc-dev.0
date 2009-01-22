Return-Path: <rs.shreeram@gdatech.co.in>
Message-ID: <49786135.5030404@gdatech.co.in>
Date: Thu, 22 Jan 2009 17:36:13 +0530
From: shreeram <rs.shreeram@gdatech.co.in>
MIME-Version: 1.0
To: wael showair <showair2003@yahoo.com>
Subject: Re: eth0: Could not attach to PHY
References: <mailman.1613.1232571316.4534.linuxppc-dev@ozlabs.org>
	<49783993.4090408@denx.de>
In-Reply-To: <49783993.4090408@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Heiko Schocher wrote:
> Hello wael,
>
> wael showair <showair2003@yahoo.com> wrote:
>   
>> i have a board with MPC8555 processor
>> uboot version 1.1.6
>> linux kernel 2.6.19-rc5
>> ltib version: 6.2.2-sv
>> gcc 3.4.3
>>
>> it boots successfully
>> i want to upgrade my linux kernel to 2.6.27
>> i upgraded the following:
>> ltib version 8.1.2-sv
>> gcc 4.1
>> linux kernel 2.6.27
>> & i kept the uboot with the same version 1.1.6
>>
>> the kernel booting stucks as follows:
>>     
If you have a board which is not an evaluation board please check you 
phy address.

-- 

-_-
 .

Regards,
R.S.Shree Ram
GDA Technologies Ltd.
