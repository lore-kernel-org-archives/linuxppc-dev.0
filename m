Message-ID: <3872E8B5.F088FE57@fadata.bg>
Date: Wed, 05 Jan 2000 08:46:13 +0200
From: "Momchil 'Velco' Velikov" <velco@fadata.bg>
MIME-Version: 1.0
To: Brendan.Simon@ctam.com.au
CC: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Linux ABI documents and powerpc supplements.
References: <38727B8B.2FBD0B8@ctam.com.au> <00010501374800.22517@enzo.bigblue.local> <3872D1EA.DF497905@ctam.com.au>
Content-Type: text/plain; charset=koi8-r
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brendan J Simon wrote:
> I am having problems getting simple shared executalbes to work on my embedded powerpc system
> (MPC860).  I am using an egcs-1.1.2 cross compiler and have cross-compiled linux-2.2.5 kernel,
> glibc-2.1 and some simple test applications.  I have an app that outputs a string every second
> using puts().  If I compile with "powerpc-linux-gcc -m860 -static" it works, but if I compile
> with "powerpc-linux-gcc -m860 -shared" it doesn't work.  I am mount root via nfs and the nfs

-shared is used to *create* a shared library. You need -Bdynamic in
order to force the executable to be linked against shared libraries.

Regards,
-velco

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
