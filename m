Mime-Version: 1.0
Message-Id: <a04310103bbcedf04902a@[199.170.89.149]>
In-Reply-To: <1068016722.12704.148.camel@gaston>
References: <20031103033529.24416.qmail@kunk.qbjnet.com>	
 <1067842481.17970.8.camel@gaston>
 <a04310106bbcd1501d614@[199.170.89.118]>	
 <1067937269.680.92.camel@gaston>
 <a04310102bbcda40d92fc@[199.170.89.159]>	
 <1067985081.707.124.camel@gaston>
 <a04310101bbce0854283b@[199.170.89.118]>	
 <1068000383.692.132.camel@gaston>
 <a04310100bbce446f4c17@[199.170.89.149]>
 <1068016722.12704.148.camel@gaston>
Date: Wed, 5 Nov 2003 11:39:33 -0600
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
From: Jeff Walther <trag@io.com>
Subject: Re: IRQS on 6 Slot Macs
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 18:18 +1100 11/05/2003, Benjamin Herrenschmidt wrote:

>Well, it's not that the OS/firm expect a MESH... It's that the B&W G3
>and the early Yikes G4 used the Paddington ASIC which contain a MESH...
>Apple didn't produce a entire new ASIC line just to strip it from there.
>
>Next MacIO chip is KeyLargo (coming with UniNorth that is AGP machines)
>and this one doesn't have MESH anymore.

Ah, thanks.

>>  The SCSI cell in CURIO is a 53C94, but CURIO provides SCSI, ethernet
>>  and serial port support all in one chip.   So the pinout of the 53C94
>>  doesn't tell one about the pinout of CURIO, except it does identify
>>  some of the pins which must be present on CURIO somewhere.
>
>Ah ? Interesting. I though like for MESH that the ESCC and MACE were
>also part of GC. They do appear as cells of GC in the OF device
>tree, so it may be that they just "split" the ASIC for production
>reasons.

CURIO is an interesting chip.   It has the unenhanced SCSI (53C94),
MACE and ESCC all on one chip.   It's an AMD chip and has no Apple
markings on it at all, which implies that it is a generally available
AMD product.   Checking their listings of datasheets, one finds
several similar chips and a part number series that would include the
79C950 but no listing for the datasheet for the CURIO/79C950.
Usually when Apple has a chip made just for Apple it has Apple
markings on it somewhere.   So I'm uncertain what the deal is with
CURIO.

Ah, I went and checked Freetradezone.com and they have a datasheet
available.  Unfortunately, as of Oct. 31 they require a subscription.
They were my best source of obscure datasheets.  Grrr.   Hard to
blame them though.   Googling on the 79C950 shows many vendors have
it available, so I guess it was generally available, so I don't
understand why AMD doesn't have the datasheet up.

Anyway, it wasn't a case of splitting an ASIC.   As closely as GC and
CURIO work together that's a reasonable conclusion.   But CURIO was
used in the x100 NuBus PowerMacs before they put it in the x500
series.   So CURIO had a couple of years of history before GC showed
up.

Jeff Walther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
