Date: Fri, 11 Oct 2002 13:17:54 -0400
From: Patrick Mahoney <pmahoney@8d.com>
To: Conn Clark <clark@esteem.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc8xx - power save modes - PIT
Message-ID: <20021011171754.GB14751@segfault.usine.8d.com>
References: <20021010183502.GA843@segfault.usine.8d.com> <3DA5F5EC.2844DE06@esteem.com> <20021010230042.GA8690@segfault.usine.8d.com> <3DA62C69.A5BD884F@esteem.com> <20021011155904.GA9579@segfault.usine.8d.com> <3DA704E7.DF667121@esteem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DA704E7.DF667121@esteem.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Conn,

> Strange you should be getting some intermitant interupts from things such as
> the real time clock and other misc things and timers. Hmmm... Must be a RPX
> hardware thing or something.

That was one of the reasons why i tried playing with the PIT... As I
said, the following code snippet crashes on me...

      init_timer(&timer);
      timer.expires=1000;
      timer.function=timer_handler;
      add_timer(&timer);

I guess I'll have to dig in the kernel sources to find out exacly why
it crashes before playing with the power modes... I'm running out of
options here... :(

Thanks a _lot_ for your help, Conn.
I very much appreciate.


Pat Mahoney

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
