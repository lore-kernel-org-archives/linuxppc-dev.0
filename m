Return-Path: <pinskia@physics.uc.edu>
In-Reply-To: <20060519051939.GJ8220@pb15.lixom.net>
References: <1148011621.13249.7.camel@localhost.localdomain>
	<20060519051939.GJ8220@pb15.lixom.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <11D4E003-85A4-48A0-9654-BEAE5600B89C@physics.uc.edu>
From: Andrew Pinski <pinskia@physics.uc.edu>
Subject: Re: [Cbe-oss-dev] Cell and new CPU feature bits
Date: Thu, 18 May 2006 22:27:17 -0700
To: Olof Johansson <olof@lixom.net>
Cc: cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 18, 2006, at 10:19 PM, Olof Johansson wrote:

>>  - Lack of data stream instructions. Until now, it was assumed that
>> those were tied to the presence
>>    of an Altivec (and they are documented in the Altivec manual).  
>> Maybe
>> we should split that to a
>>    new bit. I don't know if existing applications use them though, if
>> they do, there will be a
>>    problem to get them updated as the new bit isn't present on older
>> kernels...
>
> I'm assuming you mean the instructions described under "AltiVec Memory
> Bandwidth Management" in secion 5.2 of the Altivec PEM -- dst, dstt,
> dstst, dss and dssall?

They are nops on the Cell though.  They are also microcoded on the 970.
>
> If you're referring to the extended dcbt that includes streaming hints
> (as documented in the 64-bit PEM, but not in PPC book2 2.02), then a
> separate bit is likely needed -- obviously at least 970 seems to
> implement them.

Yes they are implemented on the 970.

Thanks,
Andrew Pinski
