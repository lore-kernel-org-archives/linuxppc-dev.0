Message-ID: <028801c1aea2$610d96a0$0900a8c0@Domain.invalid>
From: "murali nagarajan" <muralin@gdatech.com>
To: "David A. Gatwood" <dgatwood@gatwood.net>
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <Pine.LNX.3.96.1020205145050.16943C-100000@gatwood.net>
Subject: Re: Problem with ping/telnet
Date: Tue, 5 Feb 2002 16:08:02 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello David,

With your info, I am able to do a telnet from my board to the host, only if
I specify the port number. What surprises me is that the presence of both
/etc/services (entry to telnet is available with a port number) and the
/etc/protocols files. For some reason, may be the boot process is unable to
read these information.  But when I want to do a telnet to my board from my
host iMAc, I am unable to do. I get an error message "connection refused".

/proc file system is not mounted during the boot time and I mount it
immediately after getting the "bash" prompt.

With PING still looking for some leads...(I can ping from the host to my
taget board)

Any ideas?

Thanks,
Murali
-------------------------------------
> > - PING command does not work
> >   The erro message I get is   "ping: unknown protocol icmp"
>
> Don't know.  Might be a kernel compile issue or something, or it might be
> related to the second issue.  Not sure.
>
>
> > - Telnet program does not work which tells me that the service is
unknown.
> >    The error message I get is "telnet: tcp/telnet: unknown service"
>
> This one's easy.  Telnet explicitly asks the system for the default port
> number for telnet service.  If you don't have a valid /etc/services file
> (with telnet listed), it won't be able to do so, and it will fail.  If you
> specify a port number by hand (e.g. telnet foo.com 23), it should work.
> Or you can just put in an /etc/services file.
>
>
> Later,
> David
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
