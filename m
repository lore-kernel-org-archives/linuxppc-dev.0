Message-Id: <l03130302b51668503c1e@[216.164.128.178]>
In-Reply-To: <v04011700b515101599d8@[204.210.50.184]>
References: <l03130302b5145fe8d18f@[209.122.247.115]>
 <38EE7EDE.612EB99F@denise.shiny.it>
 <l03130302b4fd80d3a908@[216.164.130.191]>
 <l03130304b50c8e1b783f@[216.164.131.253]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 9 Apr 2000 13:42:42 -0400
To: Greg Noel <GregNoel@san.rr.com>
From: "DeRobertis" <derobert@erols.com>
Subject: Re: stty crtscts < /dev/ttyS1
Cc: Giuliano Pochini <pochini@denise.shiny.it>,
        linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 9:08 AM -0800 on 4/8/00, Greg Noel wrote:
>At 8:35 PM -0400 on 4/7/00, Giuliano Pochini wrote:
>
>>I don't know why this happen exactly. It seems that the printer changes
>>continuosly with very high frequency the state of CTS, which cause the
>>serial driver to loop indefinitely.
>
>At 12:05 AM -0400 4/8/00, DeRobertis replied:
>
>>Ouch! Broken hardware... how can I document this is happening, so that
>>I can demand an answer from Epson?
>
>From your messages, it's not clear to me that it's the printer.  It could
>easily be the cable.  Try replacing the cable with one that only connects
>the signals you're using and properly grounds all the other signals.

It's a Mac DIN-8 (I think that's the name) cable; I don't believe there
are any unused signals. And pulling the printer off the remote end or
the cable out of the local end both unfreeze linux. Same with turning
off the printer.

>>Or maybe I should just hack the serial driver to ignore this. And WTF
>>is the serial driver doing looking at CTS on a port with no data?!
>
>If there are multiple ports, it may not be possible to disable a specific
>interrupt for an individual port, so it always has to be enabled in case
>any port needs it.  That was the case with the hardware I had.

Same hardware does not kill the MacOS -- even when it's using the port.
Seems like a Linux problem.

However, I've come up with something interesting -- to run a Mac serial
port at the speed the printer's docs say it can (1.8Mbps), you need
external clocking... more on this in another message.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
