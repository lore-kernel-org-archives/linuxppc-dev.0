Date: Wed, 23 Apr 2003 09:59:41 -0400
From: Martin Hicks <mort@bork.org>
To: Aman <aman@mistralsoftware.com>
Cc: Mark Hatle <fray@mvista.com>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Serial Console Login Fails
Message-ID: <20030423135941.GK553@bork.org>
References: <001301c3093d$ad9c69f0$370da8c0@aman> <20030423123015.GI553@bork.org> <3EA68E1E.7090201@mvista.com> <001701c3099e$c1f900f0$370da8c0@aman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001701c3099e$c1f900f0$370da8c0@aman>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 23, 2003 at 07:16:35PM +0530, Aman wrote:
> Hi Martin
>
> I have the etc/securetty file with entry ttyS0. Actually I cant see the log
> messages since the linux boots up and gets struck in the login itself . Is
> there any other way to get the log messages. In my board , I don't have
> network support. So each I time I have to modify the ramdisk image and run
> it. I tried putting in /bin/login, however I getting the following error
> "/bin/login: error while loading shared libraries: cannot open shared object
> file
> : cannot load shared object file: No such file or directory"
> I think the related shared libraries is not there , how to find related
> shared libraries for any file.

You can check which shared libraries are required in order to run an
application with "ldd".  There should be a cross version on your host
system with your development kit.

Otherwise, I'd compile login statically (or use busybox or something
similar) to get past this hurdle and get the correct shared libs
installed.

mh

--
Martin Hicks  ||  mort@bork.org  || PGP/GnuPG: 0x4C7F2BEE
plato up 5 days, 22:50, 12 users,  load average: 0.62, 0.51, 0.55
Great Spirits have always encountered opposition from mediocre minds
						-Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
