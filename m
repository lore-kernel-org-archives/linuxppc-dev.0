Date: 3 Jun 2003 14:24:15 -0000
Message-ID: <20030603142415.21453.qmail@webmail7.rediffmail.com>
MIME-Version: 1.0
From: "ramanathan G A" <ramanathan_ga@rediffmail.com>
Reply-To: "ramanathan G A" <ramanathan_ga@rediffmail.com>
To: "Nikunj A.Dadhania" <nikunj.dadhania@fci.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re: compiling newlib for powerpc-linux
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
Thanks for the response.

Well. I tried with the '--with-newlib' flag only in my second
attempt.
It gave me the same at first time.
---------screen shot ------
[root@linuxswan newlib-powerpc]# ../newlib-1.11.0/configure
--target=powerpc-linux
Configuring for a i686-pc-linux-gnu host.
*** This configuration is not supported in the following
subdirectories:
      target-newlib target-libgloss
     (Any other directories should still work fine.)
Created "Makefile" in /root/anandapa/newlib-powerpc using
"mt-frag"
[root@linuxswan newlib-powerpc]#
--------

Can we try running the configuration for the subdirectories
(newlib and libgloss) one by one? If so, any concerns?

And why is it set to '--norecursion' by default? Any intentions
behind?

Rgds,
Ramanathan G A

On Tue, 03 Jun 2003 Nikunj A. Dadhania wrote :
>On Tue, 2003-06-03 at 15:17, ramanathan G A wrote:
> > Hi All,
> > I am trying to setup an cross development environment for
> > powerpc-linux on i686-linux.
> > Built binutils 2.13.90.0.4 and GCC (cross) 3.2 and was then
>trying
> > to configure and compile newlib 1.11.0
> > (anything wrong with using newlib here?. Mine is an embedded
> > powerpc -MPC8260- target system)
> >
> > Here is the screen shot.
> > -----------------screen shot----
> > [root@linuxswan newlib-powerpc]# ../newlib-1.11.0/configure
> > --with-newlib --target=powerpc-linux
>
>I am not sure whether you need to give --with-newlib flag when
>you are
>compiling newlib itself. Please try compiling without this
>flag.
>
>Thanks
>Nikunj
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
