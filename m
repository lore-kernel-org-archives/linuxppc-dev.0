Message-ID: <3E35238B.6010205@devcom.cz>
Date: Mon, 27 Jan 2003 13:18:19 +0100
From: Jan Damborsky <Jan.Damborsky@devcom.cz>
MIME-Version: 1.0
To: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem with data cache on MPC823E - now solved
References: <DF2B720CF774D21189EE00805FA7FA220517835A@nmrusdunsx3.nielsenmedia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wells, Charles wrote:

>Jan,
>
>While reviewing your original email, I noticed the following statement.
>
>
>
>>May be it is because we have floating BI (burst inhibit) CPU singnal.
>>
>>
>
>My MPC823UM manual (Rev 1, p. 13-36, section 13.4.9.2 BURST INHIBIT SIGNAL)
>states the following:
>
>    "This signal must be pulled up to Vdd with a pullup resistor."
>
>This is shown in figure 13-24.  Have you tried adding a pullup resistor?
>
OK, I have had to persuade development stuff for connecting pullup to BI
signal directly to
the printed circuit board (PCB) carying MPC823 chip (not so big problem,
it seems that all CPU
pins are accesible from the top side of this little PCB). And for now
all is working OK !!! Data cache
in copyback mode, instruction cache,  LCD controller drives our TFT
without problems as well.

Thank you very much for your help
                         Jan Damborsky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
