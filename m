Message-ID: <3F842077.6090504@tataelxsi.co.in>
Date: Wed, 08 Oct 2003 20:04:31 +0530
From: Omanakuttan <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: Andreas Oberritter <obi@saftware.de>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: driver for CyberPro 5202 Display Processor
References: <3F8408FB.4040501@tataelxsi.co.in> <1065618226.844.23.camel@shiva.eth.saftware.de>
In-Reply-To: <1065618226.844.23.camel@shiva.eth.saftware.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Andreas Oberritter wrote:
> On Wed, 2003-10-08 at 14:54, Omanakuttan wrote:
>
>>A google search on cyberpro 5202 chipset drivers on linux  did not
>>produce any significant result. I may have to write the drivers for
>>this, so any input is welcome. Any help/hints on other cyberpro 50xx
>>chipsets are also welcome.
>
>
> Have a look at linux/drivers/video/cyber2000fb.c
>
>

Yes I have already gone through. Seems like it requires quite large
amount of hacking to support cyberpro 5202 chipset. It directly supports
Intergraphics CyberPro 2000, 2010 and 5000 frame buffer device, but the
extent of support for 5202 is something for me to see after going
through the data sheet and comparing it with these chipset's data sheets

Any further input is welcome.

Thank you very much.
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
