Date: Mon, 19 Feb 2001 23:14:50 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Grant Erickson <erick205@umn.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SysVInit, /etc/TIMEZONE, getty_ps, telnet, and rsh
Message-ID: <20010219231450.A23090@cistron.nl>
References: <Pine.SOL.4.20.0102161326460.11498-100000@garnet.tc.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.SOL.4.20.0102161326460.11498-100000@garnet.tc.umn.edu>; from erick205@umn.edu on Fri, Feb 16, 2001 at 02:01:55PM -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


According to Grant Erickson:
> The problem I am having, which may be due to inappropriate hacking of
> sysvinit, is that sometimes processes of which 'init' is a parent do not
> inherit the environment variables exported:

They probably do inherit the environment, but simply reset the
environment internally ignoring whatever was set by the parent.

> Has anyone else modified sysvinit in this way? Any success? Did I miss
> something key in my patch?

I think you need t ostudy the source code of those misbehaving programs.

BTW, you could have achieved the same by using /etc/initscript. Could
be a shell script, but could be a small compiled executable too
that sets TZ.

Mike.
--
I live the way I type; fast, with a lot of mistakes.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
