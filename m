Date: Fri, 18 Oct 2002 10:47:53 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: install with Debian CD ok, but can't boot any kernel
Message-ID: <20021018184753.GT27982@plato.local.lan>
References: <200210180941.LAA07730@ipnmail.in2p3.fr> <20021018120711.18174@192.168.4.1> <200210181610.SAA19888@ipnmail.in2p3.fr>
Mime-Version: 1.0
In-Reply-To: <200210181610.SAA19888@ipnmail.in2p3.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Oct 18, 2002 at 06:08:05PM +0200, Xavier Grave wrote:
>
> Now that I can see the hard disk I can do all the steps to install the debian
> except the last one. I'm using the woody CD. the yaboot step seems to create
> a good yaboot.conf file in /target/etc but the only thing I have is a blank
> screen.

at the boot: prompt press tab

you will see the label name for the installed kernel, type it and:

video=ofonly

then hit enter.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
