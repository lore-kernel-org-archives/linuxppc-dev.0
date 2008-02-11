Return-Path: <alohanono@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id 0217BDDE49
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Feb 2008 22:08:38 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so1480676nfd.9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Feb 2008 03:08:36 -0800 (PST)
Message-ID: <47B02CB0.8040002@gmail.com>
Date: Mon, 11 Feb 2008 12:08:32 +0100
From: "A. Nolson" <alohanono@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: APU FPU in Virtex ppc405
References: <47ACA4BB.6010903@gmail.com>
	<fa686aa40802081132h22b91464xd150e0671ca4fc34@mail.gmail.com>
In-Reply-To: <fa686aa40802081132h22b91464xd150e0671ca4fc34@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have been checking and it seems that the APU FPU patches will give 
some headaches now, so I will probably wait until they merge them with 
the official GCC release. In any case, it seems that the FPU restricts 
the PowerPC and bus frequencies to a max of 200/100.

Anyway, thanks for the info. I will try to keep track of this in case of 
an update.

Grant Likely wrote:
> On Feb 8, 2008 11:51 AM, A. Nolson <alohanono@gmail.com> wrote:
>   
>> Hi,
>>
>>  I have just heard that Xilinx has freed the FPU module for the PPC
>> architecture in EDK9.2i. WIll I be able to make it work with my
>> Secretlab Linux 2.6.24rc3? Will the eldk toolchain for PPC_4xxfp work?
>> Will it be just a matter of integrating it with the XPS BSP?I make an
>> extensive use of floating point in my applications and this will be
>> really useful.
>>     
>
> It's been 2 years since I last played with the FPU core.  At the time
> it wasn't a complete FPU so the eldk 4xxfp toolchain would not work.
> I had to build my own.  I don't know if the new core is a complete
> implementation.
>
> Cheers,
> g.
>
>
>   
