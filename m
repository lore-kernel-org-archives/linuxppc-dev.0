Message-ID: <3E244FED.8020602@redswitch.com>
Date: Tue, 14 Jan 2003 09:59:09 -0800
From: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
MIME-Version: 1.0
To: James Don <JDon@spacebridge.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Configure 8xx_io in 2.4.21-pre3
References: <DB0585C9F6F9D411BE8F00D0B7896A4CC06064@SNCMAIL>
In-Reply-To: <DB0585C9F6F9D411BE8F00D0B7896A4CC06064@SNCMAIL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Jim,

Thank you for your suggestions. I had a working 2.4.4 (released by DENX)
kernel on my board, which has more stuff related to 8xx_io than
2.4.21-pre3. I don't know if those DENX-added stuff are necessary to
enable 8xx CPM or if the 8xx_io code in 2.4.21 is sufficient to make 8xx
CPM working. Probably I need to compare the code in these two versions
line by line.

- Shawn.

> 1.) I recommend start with UART only build of the kernel first
>
> 2.) Did you check that your PA,PB,PC, and PD pins are set up properly ...
>
> I my custom board had pins moved for things like enet on SCC ? However
> normally I believe SMC1 only can be on one pair of pins for a UART ...
> another
>
> 3.) Another thing to look at is your BRG clock for your board ... in my
> kernel I found mvista didn't look at the some parts of the hardware reset
> word that divide down my 80 Mhz reference intenerally before it goes to the
> brg ... I was really surprised this code wasn't there ...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
