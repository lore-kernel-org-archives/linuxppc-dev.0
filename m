Date: Fri, 17 Mar 2000 21:01:44 +0100
Subject: Re: KDE install (2000)
From: Alexander Bickel <A.Bickel@gmx.net>
To: "James B. Parker" <pajama1@mindspring.com>,
        LinuxPPC Developer <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B4F84DB8.2B0E%A.Bickel@gmx.net>
In-Reply-To: <B4F7E501.1C2C%pajama1@mindspring.com>
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Are you sure you installed qt version 1.x? It's in the Miscellaneous (for
Compatibilty reasons-Section in the Installer.

Also make sure you install the libgd package (called gd something - can't
remember exactly now).

I've had the same problem. Also two installs until I tried the above ­ and
it helped. See if you can get it working with this short help, otherwise
mail me and I'll check for the complete info.

Good luck

Alexander Bickel

> Von: "James B. Parker" <pajama1@mindspring.com>
> Datum: Fri, 17 Mar 2000 13:34:57 -0500
> An: LinuxPPC Developer <linuxppc-dev@lists.linuxppc.org>
> Betreff: KDE install (2000)
>
>
> This is my second install of Linux 2000.  Both times I have noticed KDE was
> not working (everything shows up in the little task bar but nothing runs).
> Also, at login, if I choose KDE never ever happens and I have to do a
> control-power-backspace to bring me back to login.  This has occurred after
> two installations of ALL packages (except the foreign language choice).
>
> So both times I tried to do an install from the command line:
> rpm -ivh k*
>
> and I get messages for several of the packages that look like:
>
> kde (whatever) requires libqt.so.1
>
> If I installed everything from the CD and the CD contains the most recent
> packages, what is going on?  I tried to re-install the qt package and I got
> the message that the package was already installed.
>
> Any info is appreciated!
> James B. Parker
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
