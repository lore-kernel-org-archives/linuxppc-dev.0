To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: Mac-on-Linux
References: <19990519235050.60265@ibrium.se> <Pine.LNX.3.96.990519210752.5706A-100000@EdMcMan.Dyn.Ez-Ip.Net> <19990520192459.17170@ibrium.se> <19990520171823.A409@jasons.dyn.kpn.cx>
Content-Type: text/plain; charset=US-ASCII
From: Stefan Berndtsson <stefan@nocrew.org>
Date: 21 May 1999 17:32:01 +0200
In-Reply-To: "Jason S."'s message of "Thu, 20 May 1999 17:18:23 -0400"
Message-ID: <87zp2ysaku.fsf@hades.nocrew.net>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Jason S." <jhsterne@mindspring.com> writes:

> On Thu, May 20, 1999 at 07:24:59PM +0200, Samuel Rydh wrote:
> 
> > > Mac-on-Linux looks very promising.  One question though, are you planning
> > > to use 603 processors?  
> 
> > I would appreciate if someone could download try the Mac-on-Linux
> > patched kernel, also changing the
> 
> > 	#define NO_RELOAD_HTAB 1
> > to
> > 	#define NO_RELOAD_HTAB 0
> 
> > in 'arch/ppc/head.S' and 'arch/ppc/mm/init.c'. This might do the
> > trick. (Then Mac-on-linux should be able to let MacOS see
> > the 603 as a 604).
> 
> I tried this on a PowerBase 180 and got a kernel panic once it
> started the emulator:
> 
> kernel: Kernel panic: kernel access of bad area pc c0046cd8 lr c004696c address 3C00 tsk mm/175

I've tried this on a Performa 6400/180 (603e), and also got a panic right after Meta-G.

>From manual work on the backtrace, the following functions are accessed:

c0044c7c: c0044c04 t insert_pte
c004498c: c004485c t page_fault
c004478c: c0044704 t mmu_data_access_hook
c0041d80: c0041d78 t access_exception

This is a cvs-kernel, but not the one from the mac-on-linux-site, 
but the patches applied cleanly.

/Stefan

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
