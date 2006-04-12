Return-Path: <afleming@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id EA98C67B16
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 09:19:54 +1000 (EST)
In-Reply-To: <1143564910.2660.4.camel@enki.eridu>
References: <20060328161431.18517.82573.stgit@vitb.ru.mvista.com>
	<1143564910.2660.4.camel@enki.eridu>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <644FB6AC-3702-41D0-A9E2-6FDEC52B819D@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] powerpc: Add FSL CPM2 device tree node documentation
Date: Wed, 12 Apr 2006 18:19:11 -0500
To: Paul Nasrat <pnasrat@redhat.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Jon Loeliger <jdl@jdl.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 28, 2006, at 10:55, Paul Nasrat wrote:

> On Tue, 2006-03-28 at 20:14 +0400, Vitaly Bordug wrote:
>> Updated the documentation to include the initial description of  
>> the CPM2
>> device that are used on PQII and PQIII families. Only initial sub- 
>> devices
>> described so far, but that should be sufficient to move the  
>> respective
>> boards to powerpc, with a reasonable minimum supporteddevice set.
>>
>
>> +	5) FCCs (Fast Communications Controllers)
>> +
>> +	  Required properties:
>> +
>> +	  - device_type : should be "network"
>> +	  - model : "FCCx", x is typically a small number depending on the
>> +	  devices amount
>> +	  - compatible : should be "fs_enet"
>> +	  - address : List of bytes representing the ethernet address of
>> +		this controller
>
> Umm should we not use local-mac-address and mac-address (and
> address-bits) as in section 3.7.4 in 1275-1994?


So no one chimed in on this.  Clearly, 1275 states that it's supposed  
to be local-mac-address or mac-address.  We use "address".  But I'm  
pretty sure we copied our ethernet node from somewhere else, so which  
one should it be?

Andy Fleming
