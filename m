Message-Id: <200006221725.TAA04909@denx.local.net>
To: Lucinda Schafer <lucsch@adaptivemicro.com>
cc: Patrick Lerda <Lerda@microprocess.com>, "'Dan Malek'" <dan@netx4.com>,
        Nguyen Xuan Hoang <hoang_nguyen@op.com.sg>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: MMU problems? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 22 Jun 2000 08:44:29 CDT."
             <A109131318C4D1119AC20060088DECE330F4B1@amwmail.adaptivemicro.com>
Date: Thu, 22 Jun 2000 19:25:04 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <A109131318C4D1119AC20060088DECE330F4B1@amwmail.adaptivemicro.com> you wrote:
>
> I agree. I believe we ARE dealing with a kernel bug, and it is particular to
> the MPC823.

What makes you think so? Have you run the same  hardware  with  other
CPUs  without  problems?  Have  you  seen  other  "good" hardware (TQ
Components, Embedded Planet) having with similar problems,  and  only
when running with 823 CPUs?

> Let's hear some success stories--embedded units in production, running in
> the field for days, shutting down power and rebooting with no kernel panics.
> That may help convince me we are dealing with a hardware issue.

OK, then here is a success story.

I have several systems in test here, a mix of 823, 850, 860, -DE, -T,
-SR, and  some  development  systems  are  in  permanent  use  by  my
customers, and I can't say I see any differences between the CPU's.

Booting or shutting down was _never_ a  problem.  We  had  the  usual
crashes  whith  early  versions of 2.2.13 when running low on memory,
but that's fixed.

With recent kernels (for instance, the  2.2.13  version  from  MV)  I
haven't  problems  for  a _very_ long time (except for the 2.4.0 test
kernels - but I don't use these in production yet).


Did you check if environmental parameters make  any  difference?  How
stable  is  your power supply - are the voltages for your board clean
and within limits?

Did you measure CPU temperatures, or did you try cooling the CPU's? I
remember early versions of some TQ modules  (MPC821  +  Adaptec  SCSI
controller  on  a  credit  card  sized modules) which got too hot and
stopped working.


And yes, I just compiled (once more) a Linux  kernel  on  one  of  my
boxes  (that's  why  I reply so late - it takes more than 140 minutes
with a NFS based root filsystem and 16 MB of RAM). You are right,  it
makes  kind  of  a good regression test - it streeses all of CPU, I/O
and (with NFS root) networking.

You asked for success stories: It works for me.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Virtual" means never knowing where your next byte is coming from.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
