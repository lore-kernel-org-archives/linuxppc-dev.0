Return-Path: <carcadiz@hotmail.com>
Received: from bay0-omc3-s17.bay0.hotmail.com (bay0-omc3-s17.bay0.hotmail.com
	[65.54.246.217]) by ozlabs.org (Postfix) with ESMTP id 6AC67DDF49
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Dec 2006 04:36:52 +1100 (EST)
Message-ID: <BAY122-F18EA74692D137001DF4729CAC80@phx.gbl>
In-Reply-To: <4b73d43f0612190934t53fdd35ap98243ba107eb446c@mail.gmail.com>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: jcrigby@gmail.com
Subject: Re: LITE5200B Powerfail
Date: Tue, 19 Dec 2006 18:36:49 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thank you very much for your help, I would have a look on that and see what 
I can do.

Regards,

  Pedro.





>From: "John Rigby" <jcrigby@gmail.com>
>To: "Pedro Luis D. L." <carcadiz@hotmail.com>
>CC: linuxppc-embedded@ozlabs.org
>Subject: Re: LITE5200B Powerfail
>Date: Tue, 19 Dec 2006 10:34:16 -0700
>
>According to the Lite5200B schematic
>http://www.freescale.com/files/32bit/hardware_tools/schematics/lite5200BSCH.pdf
>
>PSC2_4 is tied to a signal called PWR_DN_CTL_STS via a zero ohm resistor
>R88.  If you want to use PSC2_4 as something else you probably need to
>remove R88.
>
>On 12/15/06, John Rigby <jcrigby@gmail.com> wrote:
>>
>>Have you looked at the Lite5200B schematic to see where the signals in
>>question go?  Maybe you trying to drive something tied to ground high or
>>vice-versa.
>>
>>On 12/15/06, Pedro Luis D. L. <carcadiz@hotmail.com> wrote:
>> >
>> > Hi all,
>> >
>> > I not pretty sure if this is the correct forum to ask for a solution 
>>but
>> > I
>> > know that some of you have worked on a driver to make PSCs in this 
>>board
>> > work in an I2S mode.
>> >
>> > Have you ever have powerfail problems when writing the configuration
>> > registers for this mode?
>> >
>> > I´ve delimited the problem:
>> > - GPIO Port Config register stores without problems the value "111" in
>> > bits
>> > 25:27 (PSC2 to work in CODEC2 functionality with MCLK).
>> > - When I write a "1" in PSC2->SICR register bit GenClk  to ensure that
>> > clock
>> > and FrameSync are generated internally from MCLK the systems suffers a
>> > powerfail and I suppose that´s consecuence or some kind of 
>>shortcircuit.
>> > I´ve followed the same steps made by Bob Peterson in
>> > 
>>http://ozlabs.org/pipermail/linuxppc-embedded/2005-September/020210.html
>> > to write the configuration in the proper registers but I still suffer
>> > the
>> > powerfail when GenClk is activated or, if I activate that bit first,
>> > when
>> > Port Config is written.
>> > I´m also trying to understand how things are done in Roman Fietze 
>>driver
>> > but
>> > can´t find a difference. That makes me think that perhaps other
>> > registers
>> > must be modificated before driver loading. Meanwhile, I keep waiting 
>>for
>> >
>> > Grant Likely release, :-).
>> > Has this happened to someone before?
>> >
>> > Thanks for your help.
>> >
>> >     Pedro.
>> >
>> > _________________________________________________________________
>> > Horóscopo, tarot, numerología... Escucha lo que te dicen los astros.
>> > http://astrocentro.msn.es/
>> >
>> > _______________________________________________
>> > Linuxppc-embedded mailing list
>> > Linuxppc-embedded@ozlabs.org
>> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> >
>>
>>

_________________________________________________________________
Descubre la descarga digital con MSN Music. Más de un millón de canciones. 
http://music.msn.es/
