Message-Id: <l03130302b5145fe8d18f@[209.122.247.115]>
In-Reply-To: <38EE7EDE.612EB99F@denise.shiny.it>
References: <l03130302b4fd80d3a908@[216.164.130.191]>
 <l03130304b50c8e1b783f@[216.164.131.253]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 8 Apr 2000 00:05:56 -0400
To: Giuliano Pochini <pochini@denise.shiny.it>
From: "DeRobertis" <derobert@erols.com>
Subject: Re: stty crtscts < /dev/ttyS1
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 8:35 PM -0400 on 4/7/00, Giuliano Pochini wrote:

>What is connected to the serial port ?  When I enable RTS/CTS on ttyS1
>and there is my Epson 740 attached, the whole system freezed.

Same thing attached.

>I don't
>know why this happen exactly. It seems that the printer changes continuosly
>with very high frequency  the state of CTS, which cause the serial driver
>to loop indefinitely.

Ouch! Broken hardware... how can I document this is happening, so that
I can demand an answer from Epson?

Or maybe I should just hack the serial driver to ignore this. And WTF
is the serial driver doing looking at CTS on a port with no data?!


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
