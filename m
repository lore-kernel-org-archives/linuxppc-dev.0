Message-ID: <3E34E2CE.3040102@devcom.cz>
Date: Mon, 27 Jan 2003 08:42:06 +0100
From: Jan Damborsky <Jan.Damborsky@devcom.cz>
MIME-Version: 1.0
To: "Wells, Charles" <Charles.Wells@NielsenMedia.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem with data cache on MPC823E
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
I think it is the reason, why our board behaves so erraticaly (we have
developed our board with
MPC823UM Revision 0, there is only "should be pulled up", but in
Revision 1 is "must be pulled up",
so we have to base our next development on newest documentation - like
it "must be" always).
Because when I set BIH bit in OR register, there are no problems. I
think because there are no bursts.
But solution of this problem is not so trivial. Because MPC823 is in BGA
package and BI signal
is unconnected, the appropriate pin is unreachable. So I am not sure we
will be successful
in connecting BI to pullup, may be we will be forced to create new PCB,
but it is future.

>Also, where did you get your UPM table for DRAM?

We have derived UPM settings from Motorola MPC823ADS documentation,
and verified them in Motorola graphical software for UPM settings
visualisation, so I think it is OK.

                                                                Thank
you for your help very much,

                Jan Damborsky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
