Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 99D142BDC5
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 21:13:18 +1000 (EST)
Date: Tue, 21 Sep 2004 07:06:53 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20040921104034.6DCA0C108D@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0409210700390.9187@dell.enoriver.com>
References: <20040921104034.6DCA0C108D@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linuxppc-dev mailing list <linuxppc-dev@ozlabs.org>
Subject: Re: thoughts and questions on 8xx patches 
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 21 Sep 2004, Wolfgang Denk wrote:

> In message <Pine.LNX.4.60.0409210605090.9033@dell.enoriver.com> you wrote:
>>
>>    rather than get into more detailed discussion on microcode patches,
>> here's a (partial) patch that represents what i'd really, really,
>> *really* like to see.
> ...
>> +config I2C_SPI_PATCH
>> +	bool "I2C/SPI relocation patch"
>> +
>> +config I2C_SPI_SMC1_PATCH
>> +	bool "I2C/SPI/SMC1 relocation patch"
>
> Why? As far as I understand the I2C/SPI patch has been obsolteted  by
> the I2C/SPI/SMC1 patch. So only the latter is needed.

uh huh.  even though, as i've already pointed out, the code in 
micropatch.c in *both* your source tree and the linuxppc-2.5 tree is 
broken in that, if you applied the SMC patch, it would have (AFAICT) 
caused a conflict because of an erroneously low value of RPBASE.

it's a bit presumptuous to declare that a broken patch has obsoleted 
one that actually works, don't you think?

rday
