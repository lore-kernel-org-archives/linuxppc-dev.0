Subject: [OT] Re: Why I can't bind the 1023 port?
From: Bastien Nocera <hadess@hadess.net>
To: Daniel Lao <laodx@gzjpg.com>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <200206111046140.SM00168@------>
References: <200206111046140.SM00168@------>
Date: 11 Jun 2002 03:38:19 +0100
Message-Id: <1023763100.31410.487.camel@dozo>
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2002-06-11 at 03:18, Daniel Lao wrote:
>
> I recently met some trouble with the "rcp" command. My "rcp" could not work
> even if I have correctly configure the remote host.
> When I run rcp in my local host, it print "Permission deny" to the terminal.
>
> So I re-compiled rcp and debugged it by GDB. I found that it fail while tried to
> bind the 1023 port for connecting with the remote rshd.
>
> I though the 1023 port might be protected, and I wrote a program as below:
<snip>
> The running result was that I could not bind these ports: 1023, 1022, ...
> but it was success in bind 1024 port.
> And while I su to as the super-user, I could bind all these ports!
> I am wondering if the ports were really protected, and how can I use the ports?
>
> Should anyone be kind to give me some advise?
> :)

ports < 1024 are reserved to the super-user. This is clearly very much
off topic btw.

Cheers

--
/Bastien Nocera
http://hadess.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
