Message-ID: <3EBB0244.3080109@esteem.com>
Date: Thu, 08 May 2003 18:20:04 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: emanuel stiebler <emu@ecubics.com>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: What PCI specs will I need?
References: <3EBAD545.50707@esteem.com> <3EBAE3C4.1040007@ecubics.com>
In-Reply-To: <3EBAE3C4.1040007@ecubics.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Emanuel,



emanuel stiebler wrote:
> Conn Clark wrote:
>
>>
>> Hello all,
>
>
> Please explain a little further what you're trying to do ...
>

We are building an 802.11 access point. We need to design a system with
at least two mini-PCI type III slots. Our company specializes in
industrial communications which for reliability sake requires a higher
transmit power to swamp out any noise, microwave ovens, or idiots using
bluetooth, it also gives us added range too. Most 802.11 systems put out
about 100mWatts maximum  (if you get a good one). Our current generation
of products puts out 1W (the maximum allowed by law in the US and
Canada). In our next generation product we are looking to do both
802.11a and 802.11b/g simultaniously, hence the need for two slots.


>> Our company is being forced to buy modules in mini-PCI because nobody
>> will sell us the discrete componets we desire.
>
>
> What are the part you can't buy ?
>

Unfortunatly, we don't do high enough volume for the makers of the
802.11a and 802.11g part manufacturers (ALL of THEM) for them to sell us
the chips directly and they are not going through distributers with the
desired parts. They won't even give us data sheets (Damn lawyers!). The
only way for us to obtain the parts is on modules made buy someone else
on mini-PCI cards. (If you want to see one just go buy a regular
802.11a/b/b+/g PCI card and take the sheild off)



> What is mini-PCI ? Compact-PCI or CPCI, or CardBUS, or ?

Mini-PCI is a PCI spec for lap tops. Unlike cardbus it is very much like
PCI as far as signals and such. Basicaly its just has a smaller
connector and overall dimmensions and can't supply as much power or
provide 12V.

>
>> So we are going to have
>> to build an embedded computer to use them. I know we will need the basic
>> specification, but I was wondering if we need to get the BIOS
>> specification as well or does Linux handle it?
>
>
> There is no BIOS on PowerPCs, you can have a boot program
> like u-boot, which is doing a part of this job before linux gets booted

U-Boot is the BIOS but I'm not to clear on the responsibilities of what
its supposed to do. Thats what I need to know. Does the PPC Linux Kernel
take care of this or does U-boot have to. (Note: If U-Boot has to I may
have to write it)

>
>> Many thanks in advance,
>>
>>     Conn
>
>
> cheers,
> emanuel
>
>
>> --

<snip>

>>
>

Many thanks.


Conn
--

*****************************************************************
   If you live at home long enough, your parents will move out.
  (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
