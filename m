Message-ID: <20000327161229.1217.qmail@wwcst271.netaddress.usa.net>
Date: 27 Mar 00 09:12:29 MST
From: Robert Shaw <rshawppc@netscape.net>
To: mlan@cpu.lu
Subject: Re: [Re: PCI address collisions on 2.3.x kernels?]
CC: linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners <mlan@cpu.lu> wrote:

> Can you send us a complete log of the error message along? Also the
> reason it says 'Rebooting in 180 secs'? It's hard to diagnose anything
> without that information...

Well, I can try tonight. Problem is, it crashes so soon that nothing appears
in the logs when I reboot with a good kernel. So I will have to write it down
and send it to you.

The "Rebooting in 180" message comes after it complains that it can't mount
the root volume. This is caused by the improper handling of the IDE bus. When
it goes to detect the drives it reports all kinds of jibberish, and thinks the
drives are huge, or really small.

I will try to write as much info down that I can tonight and send it to you.
Do you recall what option in the config turns off all the USB debug messages?
I don't see it in the menus (using menuconfig or xconfig) like it used to
appear in the stable (2.2.x) kernels.

Thx.

-Robert
 mailto:rshaw@linuxppc.org
 icq:45688313
 http://www.linuxppc.org/BlueG3/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
