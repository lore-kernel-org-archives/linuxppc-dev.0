Message-ID: <A109131318C4D1119AC20060088DECE330F49F@amwmail.adaptivemicro.com>
From: Lucinda Schafer <lucsch@adaptivemicro.com>
To: diekema@bucks.si.com, linuxppc-embedded@lists.linuxppc.org
Subject: RE: Software Emulation Kernel Panic--specific information
Date: Wed, 21 Jun 2000 14:18:38 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Oops. One of my coworkers corrected me and asks:

I looked into the data cache setting in the MPC823 and, as far as I know, it
is disabled. Can you ask if there is something specific that we can look at
to determine if the caches are disabled and if there is something in Linux
that should be disabled?


Thanks.

-----Original Message-----
From: Lucinda Schafer [mailto:lucsch@adaptivemicro.com]
Sent: Wednesday, June 21, 2000 2:13 PM
To: diekema@bucks.si.com; linuxppc-embedded@lists.linuxppc.org
Subject: RE: Software Emulation Kernel Panic--specific information



- What processor are you using? MPC823
- Have you tried running with caches disabled? No, is this important?
- When do this problem happen? Just at the end of boot up 1 of every 1000
bootups
- Can you boot to a stand alone shell? Yes except when this happens
- Can you boot to multi-user? Yes, except when this happens
- What Linux bits are you using? ??not sure which bits to which you are
referring...

-----Original Message-----
From: diekema@bucks.si.com [mailto:diekema@bucks.si.com]
Sent: Wednesday, June 21, 2000 2:09 PM
To: lucsch@adaptivemicro.com
Subject: Re: Software Emulation Kernel Panic--specific information


> The results of the backtrace are as follows (manual, not by your script):

> C0016204  put_dirty_page
> C0016A98  handle_mm_fault
> C0009098  do_page_fault
> C0002544  _switch
> 018A4490  ???
> 300E88A4  ???
> 0180C6D4  ???
> 0180C5D8  ???
> 01803250  ???
> 01802B64  ???
> 01801D80  ???

> Does this tell us that we have a page that is not handled properly? Why?

I haven't been paying too much attention to your problem.  So, you
might of already answered these questions?

- What processor are you using?
- Have you tried running with caches disabled?
- When do this problem happen?
- Can you boot to a stand alone shell?
- Can you boot to multi-user?
- What Linux bits are you using?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
