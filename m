Date: Sat, 18 Mar 2000 13:10:20 -0700 (MST)
From: Dan Burcaw <dburcaw@terraplex.com>
To: jingai <jingai@floatingpenguins.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Re: YUP and RPM dependencies
In-Reply-To: <200003181955.OAA02857@shell.faradic.net>
Message-ID: <Pine.LNX.4.10.10003181307070.2095-100000@newhope.terraplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I realize this, but I was just wanting a package management tool like the
> Debian distros ship with *without* having to write scripts such as this.
> Unfortunately I have a job at which I work far too many hours and just
> haven't the time.  I posted this to the dev list to make other developers
> aware of the problem with YUP so it can be fixed -- I'd fix it myself, but
> I 1) don't know Python at all, and 2) haven't the time to learn it.

Are you trying to update a LinuxPPC machine to CS 1.2 with yup?
This may or may not work and provide lots of fun dependency problems.

Currently there isn't a way to disable the sanity checks. You chould try
manually installating packages that yup complained about and see if you
were then able to get through the sanity checks.


> > Ummm... and BTW: is it really so difficult to  check  with  a  search
> > engine? I quich search at freshmeat for "update new RPM" shows
> >
> > rhlupdate
> >    rhlupdate is a small configurable perl script that will connect to
> >    your favorite Red Hat site and update all of the RPMS you have
> >    installed. It also allows you to specify what packages not to
> >    upgrade.
> >
> > It's there, you just have to look a bit around...
>
> Again, sorry.  I didn't think to look because I figured it would have been
> posted all over the list when such a tool was released -- afterall, I'm
> sure many RedHat users get pretty tired of manually updating packages.

Can rhlupdate do:

yup install mpg123

and download mpg123 while also downloading any dependencies that your
system needs to meet before installing mpg123, then install those
packages?


Regards,
Dan

Terra Soft Solutions, Inc.
 Yellow Dog Linux
 "The Ultimate Companion for a Dedicated Server"
 http://www.yellowdoglinux.com/

 Black Lab Linux
 Advanced Workstations and Parallel Solutions
 http://www.blacklablinux.com/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
