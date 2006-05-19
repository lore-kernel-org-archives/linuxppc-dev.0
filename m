Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <11D4E003-85A4-48A0-9654-BEAE5600B89C@physics.uc.edu>
References: <1148011621.13249.7.camel@localhost.localdomain>
	<20060519051939.GJ8220@pb15.lixom.net>
	<11D4E003-85A4-48A0-9654-BEAE5600B89C@physics.uc.edu>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D3377AEA-2C43-40F5-A8F6-0C08CD99866C@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] Cell and new CPU feature bits
Date: Fri, 19 May 2006 09:49:18 +0200
To: Andrew Pinski <pinskia@physics.uc.edu>
Cc: Olof Johansson <olof@lixom.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I'm assuming you mean the instructions described under "AltiVec  
>> Memory
>> Bandwidth Management" in secion 5.2 of the Altivec PEM -- dst, dstt,
>> dstst, dss and dssall?
>
> They are nops on the Cell though.

And that is a compliant implementation.  I don't see a need
or real use for a feature bit here, esp. if we do get one for
the extended dcbt insns (which often are used as a replacement
for the data streaming insns).

> They are also microcoded on the 970.

No, they are cracked, instead.  Much lower hit.  They are completion
serialized though, so the only insn in an issue group, etc.


Segher
