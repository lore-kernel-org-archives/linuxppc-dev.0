Message-ID: <001701c3099e$c1f900f0$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "Mark Hatle" <fray@mvista.com>, "Martin Hicks" <mort@bork.org>
Cc: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <001301c3093d$ad9c69f0$370da8c0@aman> <20030423123015.GI553@bork.org> <3EA68E1E.7090201@mvista.com>
Subject: Re: Serial Console Login Fails
Date: Wed, 23 Apr 2003 19:16:35 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Martin

I have the etc/securetty file with entry ttyS0. Actually I cant see the log
messages since the linux boots up and gets struck in the login itself . Is
there any other way to get the log messages. In my board , I don't have
network support. So each I time I have to modify the ramdisk image and run
it. I tried putting in /bin/login, however I getting the following error
"/bin/login: error while loading shared libraries: cannot open shared object
file
: cannot load shared object file: No such file or directory"
I think the related shared libraries is not there , how to find related
shared libraries for any file.

Thanking you in advance
Regards
Aman


----- Original Message -----
From: "Mark Hatle" <fray@mvista.com>
To: "Martin Hicks" <mort@bork.org>
Cc: "Aman" <aman@mistralsoftware.com>; "linuxppc embedded"
<linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, April 23, 2003 6:29 PM
Subject: Re: Serial Console Login Fails


> Martin Hicks wrote:
> > On Wed, Apr 23, 2003 at 07:41:40AM +0530, Aman wrote:
> >
> >>"T0:23:respawn:/sbin/getty -L ttyS0 9600 vt100"
> >>Bcos of which during the linux bootup , there wont be console message on
the
> >>screen , after some time , there is a login prompt
> >><none>login:
> >>If I try login then it waits for some seconds and then display the same
i.e
> >><none>login:
> >
> >
> > You don't have "ttyS0" in /etc/securetty
>
> Actually if that was the case you'd get a login denied message of some
type..
> If you don't have an /etc/securetty then it allows all logins.. (that is
the
> typical setup of systems we recommend for our customers development
systems..)
>
> The problem is that they are missing either the pam libraries or they are
> missing /bin/login.  Turn on syslogd, set a console to go right to a shell
and
> look at the output of /var/log/messages.  This will tell you what is
missing.
> It is usually /bin/login is missing, secondary cause is PAM (or a module)
is
> missing, or that your /etc/passwd and/or /etc/group files are missing or
corrupt.
>
> (I wonder if we should create a FAQ for this list and post it once a
month..
> this question/answer come up at _LEAST_ once a week.. doesn't anyone read
the
> list archives?)
>
> --Mark
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
