Message-ID: <3BE7165E.6A9A2A6D@mvista.com>
Date: Mon, 05 Nov 2001 16:44:46 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: John F Davis <johndavi@us.ibm.com>
Cc: linuxppc-embedded@lists.linuxppc.org, support@mvista.com
Subject: Re: mvista 2.0 cdk and login username and password
References: <OF65A95CC9.1E398D60-ON85256AFB.006B09BF@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John F Davis wrote:
>
> Hello
>
> What's the root login password for a newly installed sbs-k2, cdk 2.0,
> target login?  The final paragraph of the sbs-k2
> installation section (in the pdf) says to login, but doesn't specify a
> password for root.

There is no root password by default.  Normally you type root and you
are logged in.. (Security hole?  for a desktop/workstation distro yes,
but not for an embedded distro!)

> I installed the cd and when I try to login to a nfs root mounted partition,
> I get a login prompt, but I can't login.
> My installation doesn't   have a /..../target/etc/passwd file, which leads
> me to believe I missed something during
> the install.  However, I searched the CD for rpm's and none of them
> owns/supplies  the /.../target/etc/passwd file.
> Am I supposed to modify the inittab on the host machine so it boots single
> user mode and create the /etc/password
> file by hand, modify the inittab for multiuser mode and then reboot?

Sounds like the install did not work.  (Did you use the installer?)  The
"base-passwd" package controls the password files.  It installs a
passwd/group template into (target filesystem) /usr/share/base-passwd
and then proceeds to copy them over into /etc/passwd,group.  This is
done in case you already have an /etc/passwd,group so that it will not
be over written, but "upgraded".

> Also, when am I going to get a hardhat zone login id?  I am sure MVista has
> a FAQ which addresses this issue.

If you are a paying customer, contact your support representative, and
not the linuxppc-embedded list as they have nothing to do with our
product.

Mark Hatle
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
