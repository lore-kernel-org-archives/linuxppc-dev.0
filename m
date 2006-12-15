Return-Path: <carcadiz@hotmail.com>
Received: from bay0-omc3-s38.bay0.hotmail.com (bay0-omc3-s38.bay0.hotmail.com
	[65.54.246.238]) by ozlabs.org (Postfix) with ESMTP id 4481267BC5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Dec 2006 02:33:23 +1100 (EST)
Message-ID: <BAY114-F102E7A8BBB9E25B0CC42FCAD40@phx.gbl>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: LITE5200B Powerfail 
Date: Fri, 15 Dec 2006 16:33:18 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I not pretty sure if this is the correct forum to ask for a solution but I 
know that some of you have worked on a driver to make PSCs in this board 
work in an I2S mode.

Have you ever have powerfail problems when writing the configuration 
registers for this mode?

I´ve delimited the problem:
- GPIO Port Config register stores without problems the value "111" in bits 
25:27 (PSC2 to work in CODEC2 functionality with MCLK).
- When I write a "1" in PSC2->SICR register bit GenClk  to ensure that clock 
and FrameSync are generated internally from MCLK the systems suffers a 
powerfail and I suppose that´s consecuence or some kind of shortcircuit. 
I´ve followed the same steps made by Bob Peterson in
http://ozlabs.org/pipermail/linuxppc-embedded/2005-September/020210.html
to write the configuration in the proper registers but I still suffer the 
powerfail when GenClk is activated or, if I activate that bit first, when 
Port Config is written.
I´m also trying to understand how things are done in Roman Fietze driver but 
can´t find a difference. That makes me think that perhaps other registers 
must be modificated before driver loading. Meanwhile, I keep waiting for 
Grant Likely release, :-).
Has this happened to someone before?

Thanks for your help.

    Pedro.

_________________________________________________________________
Horóscopo, tarot, numerología... Escucha lo que te dicen los astros. 
http://astrocentro.msn.es/
