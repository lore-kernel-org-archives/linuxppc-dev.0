Message-ID: <387EEC1E.DEE0BFB6@huawei.com.cn>
Date: Fri, 14 Jan 2000 17:27:59 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: karuottu@freenet.hut.fi
CC: Brendan.Simon@ctam.com.au,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
        crossgcc@sourceware.cygnus.com
Subject: Re: cross-compiling & debugging embedded-linux apps
References: <386C3615.E14AE6DD@ctam.com.au> <387094AD.8F3145F2@freenet.hut.fi> <3871A78E.F18B0161@ctam.com.au> <38725315.A8F89547@freenet.hut.fi>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kai Ruottu wrote:

> Brendan J Simon wrote:
> >
> > Kai Ruottu wrote:
> >
> > > 1. Using 'strings' to see the 'hard-wired' name of the dynamic linker in
> > >    the executable:
> > >
> > >         E:\usr\local\samples>strings tst_ppc-linux.x | more
> > >         /lib/ld.so.1    <------- !!!
> > >         __gmon_start__
> > >         libc.so.6
> >
> > The output of "powerpc-linux-strings bjs1-shared" looks OK to me.
> > $ powerpc-linux-strings bjs1-shared
> > _DYNAMIC
> > _GLOBAL_OFFSET_TABLE_
> > __gmon_start__
>
>  When your output from 'strings' didn't show the 'ld.so.1' (didn't it really?)
> I tried removing the '--dynamic-linker xxxxx' from my specs, and got then :

Now I have a similar problem with the dynamic linker "ld.so.1". Can you tell me
how can I remove the "--dynamic-linker XXXX" and set the default dynamic-linker to other
directories ,ie, /syslib/ld.so.1, instead of /lib/ld.so.1?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
