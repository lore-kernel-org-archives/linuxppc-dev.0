Date: Thu, 9 Dec 1999 11:02:27 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Gary Thomas <gdt@linuxppc.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: RE: Mozilla preM12 ppc rpms...
In-Reply-To: <XFMail.991209110250.gdt@linuxppc.org>
Message-ID: <Pine.LNX.4.10.9912091055550.24792-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 9 Dec 1999, Gary Thomas wrote:

> Where can I find all of the required pieces?
> 
> [root@icarus gary]# rpm -ivUh /tmp/mozilla-5.0-M11.ppc.rpm 
> error: failed dependencies:
>         glibc >= 2.1.3-0h is needed by mozilla-5.0-M11

devel.linuxppc.org/users/fsirl/R5/RPMS/ should have glibc

>         libIDL-0.6.so.0 is needed by mozilla-5.0-M11

libIDL should be in the latest Orbit (the R5 orbit should be fine)

>         libgtkmozilla.so.0 is needed by mozilla-5.0-M11

sorry, this was a mistake in my spec, you can --nodeps once you get down
to this one.

>         libstdc++-libc6.1-2.so.3 is needed by mozilla-5.0-M11

libstdc++-2.10.0-1d also from franz's directory

>         libc.so.6(GLIBC_2.1.3) is needed by mozilla-5.0-M11

glibc-2.1.3 ofcourse



>
>------------------------------------------------------------------------
> Gary Thomas                              |
> email: gdt@linuxppc.org                  | "Fine wine is a necessity of
>    ... opinions expressed here are mine  |        life for me"
>        and no one else would claim them! |
>                                          |      Thomas Jefferson
> ------------------------------------------------------------------------
> 
> 

ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
