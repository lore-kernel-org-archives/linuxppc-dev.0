Message-Id: <200003180953.KAA13555@denx.local.net>
To: jingai@floatingpenguins.com
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: YUP and RPM dependencies 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 17 Mar 2000 20:22:17 EST."
             <200003180622.BAA20354@shell.faradic.net>
Date: Sat, 18 Mar 2000 10:53:35 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <200003180622.BAA20354@shell.faradic.net> you wrote:
>
> After I heard about the YellowDog Update Program (YUP) from someone on this
> list, I went and downloaded the RPM and installed it.  However, it
...
> But, as a side note, I'm ecstatic that this sort of app is finally out.. I


Ummm... this is a *developer* mailing list - but where, oh  where  is
the  good old Unix tradition of using the toolbox? Even if you do not
find a fancy tool with GUI and bells and whistles,  you  always  have
the toolbox right at your fingertips.

Where is the problem:

- use "rpm -qa" to get a listing of all installed packages
- use perl and/or sort, awk, sed to separate package name and version
- use wget or ncftp or ftp + expect to get a directory listing from
  your favorite FTP mirror with update packages
- use perl and/or sort, awk, sed to generate a list of packages that
  are installed in your system, and that have never versions on the
  FTP server
- generate and run the necessary commands to nstall those packages?

In ten minutes you will have a script of about 100 lines  which  will
do  exactly  what you want... And as an additional benefit you can go
ecstatic that you have written it yourself, and you probably  learned
a few new things, too.


Ummm... and BTW: is it really so difficult to  check  with  a  search
engine? I quich search at freshmeat for "update new RPM" shows

rhlupdate
   rhlupdate is a small configurable perl script that will connect to
   your favorite Red Hat site and update all of the RPMS you have
   installed. It also allows you to specify what packages not to
   upgrade.

It's there, you just have to look a bit around...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Experience is what causes a person to make new  mistakes  instead  of
old ones.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
