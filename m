Date: Fri, 26 Jan 2001 15:12:15 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: Amit Chaudhary <amitc@brocade.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao m ode
Message-ID: <20010126151215.B13893@allspice.cs.swarthmore.edu>
References: <FFD40DB4943CD411876500508BAD0279014543B5@sj5-ex2.brocade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FFD40DB4943CD411876500508BAD0279014543B5@sj5-ex2.brocade.com>; from amitc@brocade.com on Fri, Jan 26, 2001 at 11:48:40AM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 26, 2001 at 11:48:40AM -0800, Amit Chaudhary <amitc@brocade.com> wrote:
> Though i cannot help you with your exact problem, some pointers.
> 1. The log should be typicall in /var/log/messages as long  as you
> have syslogd and klogd running.

Unfortunately, since /var lives on the same bus, this doesn't help.  But
I'll try setting up a minimal linux installation on the other SCSI bus
and burning a CD, and will hopefully then find something out.

> 2. For information on sysrq, check Documentation/sysrq.txt in the
> linux kernel sources. You will have to rebuilt your kernel to enable
> SysRq.

Great, I'll look into this.

Thanks for the advice!

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
