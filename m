Mime-Version: 1.0
Message-Id: <p06001805bb31dea62840@[192.168.9.138]>
In-Reply-To: <XFMail.20030709165850.pochini@shiny.it>
References: <XFMail.20030709165850.pochini@shiny.it>
Date: Wed, 9 Jul 2003 11:42:12 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: OT: wanting to write PCI daemon
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  > see <http://www.apple.com/Power Mac/specs.html>, the low end model.
>
>It's http://www.apple.com/powermac/specs.html

I have no idea how I screwed that link up.


>I can't see anything about 5V PCI compatibility in that
>page.

We had mistakenly interpreted "Three open full-length 33MHz, 64-bit
PCI slots" as 5V PCI slots, the same as their past PowerMac models.

>  But in the preliminary specs
><http://developer.apple.com/documentation/Hardware/Developer_Notes/Macintosh_CPUs-G5/PowerMacG5/PowerMacG5.pdf>
>at pages 27 and 73:
>
>"The connectors to the PCI or PCI-X slots are 3.3V keyed [...]
>5V keyed or signalling cards do not work in the Power Mac G5 computer".

Yup. Dawn's early light...


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
