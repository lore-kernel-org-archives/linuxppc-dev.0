Message-ID: <3C723F98.7050402@elsoft.ch>
Date: Tue, 19 Feb 2002 13:05:44 +0100
From: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
Cc: andrew may <acmay@acmay.homeip.net>, Armin <akuster@pacbell.net>,
	Stefan Roese <stefan.roese@esd-electronics.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405 MII-PHY communication problem (was: Re: PPC405gp enet Soft Reset)
References: <20020207191741.A26185@ecam.san.rr.com> <EFEAIMDCOOOHIEPHDNFJOEJBDKAA.stefan.roese@esd-electronics.com> <20020208103557.A27732@ecam.san.rr.com> <3C63AE1A.7000907@pacbell.net> <20020208120140.B27732@ecam.san.rr.com> <3C67B119.4080702@elsoft.ch> <20020211164906.A1822@ecam.san.rr.com> <3C6A25BC.7010704@elsoft.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

The problem with the even-numbered PHY register addresses seems to be
caused by a too weak or totally missing pullup resistor on the MDIO line.

David Müller (ELSOFT AG) wrote:
>
> Hi
>
> andrew may wrote:
>
>> On Mon, Feb 11, 2002 at 12:55:05PM +0100, David Müller (ELSOFT AG) wrote:
>>
>>> Hi
>>>
>>> andrew may wrote:
>>>
>>>> Here is a log from ppcboot since it is easy to test this there
>>>> without doing
>>>> a kernel build. My phy is at address 0x1f.
>>>>
>>>> => mii read 0x1 2
>>>> 07FF
>>>> => mii read 0x1 3
>>>> read err 3
>>>> a2: read: EMAC_STACR=0xffffc023, i=2
>>>> Error reading from the PHY
>>>> 07FF
>>>>
>>>>
>>> I'm seeing this error too on our boards. But i'm not certain, if it's a
>>> problem of the MII controller in the 405 or a problem of the LXT971.
>>> What revision of the 405 do you have? What clock frequency your 405
>>> run at?
>>>

[old stuff deleted]



Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
