Date: Thu, 26 Oct 2000 13:34:47 +0300 (EET DST)
From: Topi Kanerva <tkanerva@ees2.oulu.fi>
To: Chris Leishman <masklin@debian.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: airport woes?
In-Reply-To: <20001024151644.A660@nina.dev.fol>
Message-ID: <Pine.GSO.4.21.0010261319290.16028-100000@stekt6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 24 Oct 2000, Chris Leishman wrote:

>I've been using ssh to connect to remote hosts, and needless to say the
>response time is shocking.
>
>However, I've also had problems where the session totally locks up - I type at
>the terminal as much as I like, but nothing reaches the other end.  At first I
>put this down to the crappy network link.  However I've also noticed more
>recently that only _half_ the connection craps out - I can still receive data
>from the remote server.  Weird.
>
>Then today I switched to use ethernet instead of the airport (I was
>transfering some large files and wanted to use 100Mb), and I noticed that I
>wasn't getting the lockup problems with the remote hosts.
>
>I'm using benh's latest kernel and airport driver.  Now I can't think what
>would be causing this, but I thought you'd like to know.  Anyone else seen
>this problem?

Me. I went nuts one day when my ssh connections got constantly stuck and
the only thing I could do was to killall ssh and restart the
connection... I blamed about every part of the network, and finally
realized that I wasn't getting this symptom as long as I was using the GMAC
interface instead of airport... I'm using kernel 2.2.17pre20-ben3 and
aswell Ben's newest airport driver... And yes, if you e.g. run irc on one
session, you can easily see that even though you cannot transmit any
characters on the remote host, it seems that the other people are writing
to you nonetheless. So, it's a pretty weird and unexplainable problem. Ben?


-topi


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
