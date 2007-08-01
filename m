Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070801021541.GE31391@localhost.localdomain>
References: <20070730151628.GA5100@ru.mvista.com>
	<20070801021541.GE31391@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1a27a299b62c4b3a1a1f8fe8912e8e40@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 5/6] PowerPC 440EPx: Sequoia board support
Date: Wed, 1 Aug 2007 07:01:17 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +	{ /* 440EPX  - without Security/Kasumi  */
>> +		.pvr_mask		= 0xf0000fff,
>> +		.pvr_value		= 0x200008D4,
>> +		.cpu_name		= "440EPX - no Security/Kasumi",
>> +		.cpu_features		= CPU_FTRS_44X,
>> +		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU, /* 
>> 440EPX has an FPU */
>> +		.icache_bsize		= 32,
>> +		.dcache_bsize		= 32,
>> +	},
>
> Since the with/without Security/Kasumi versions have no differences in
> their cputable entry other than the PVR, couldn't you just remove the
> relevant PVR bit from the mask and use a single entry?

And get rid of the stupid "has an FPU" comment at the same time
please :-)


Segher
