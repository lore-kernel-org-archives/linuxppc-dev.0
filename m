Message-ID: <3D04A571.4020309@cray.com>
Date: Mon, 10 Jun 2002 08:11:13 -0500
From: David Updegraff <dave@cray.com>
MIME-Version: 1.0
To: Stefan Roese <stefan.roese@esd-electronics.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405GPr
References: <EFEAIMDCOOOHIEPHDNFJIELDEAAA.stefan.roese@esd-electronics.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefan

We got one in I made some "proof of concept" changes to PPCBOOT/LinuxPPC
to make it boot ok.. have not played with the extra clocking
register strap values though; we just plopped it into our
405GP socket and ran @200 Mhz.  Worked...

I noticed that the PVR on the unit we got was a bit different:
ibm specs said
	0x50910950
..but I got
	0x50910951

Is there a doc. somewhere that tells us what the ranges of PVRs
for this chip can legitimately be?

>>>Anyone playing with adding IBM 405GPr to the cputable?
>>
>>Stephan said on the PPCboot list that he will have boards with
>>them soon. He has done patches for PPCBoot so the kernel may not
>>be far off. It will still be a couple of weeks before I get a
>>board with one yet.
>
>
> Right! As promised PPCBoot will be done next week, and linux will follow (if
> I am still the first) pretty soon.
>
> Stefan.
>
>
>



--
David Updegraff / dave@cray.com / 218.525.1154


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
