Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-105.bluehost.com (outbound-mail-105.bluehost.com
	[69.89.18.5]) by ozlabs.org (Postfix) with SMTP id 2EDDEDDE39
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  2 Mar 2008 15:19:50 +1100 (EST)
Received: from 70.15.107.162.res-cmts.eph.ptd.net ([70.15.107.162]
	helo=hp-dhlii.dlasys.lcl)
	by host200.hostmonster.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68) (envelope-from <dhlii@dlasys.net>) id 1JVffs-0001if-Rc
	for linuxppc-embedded@ozlabs.org; Sat, 01 Mar 2008 21:19:46 -0700
Message-ID: <47CA2AC7.50602@dlasys.net>
Date: Sat, 01 Mar 2008 23:19:19 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: ML403 Linux port questions
References: <ADA5878BA63680469C75C14CEEE2FE28012F482B@mail.serveron.com>
	<fa686aa40802291246v676042davca91e21a08846846@mail.gmail.com>
In-Reply-To: <fa686aa40802291246v676042davca91e21a08846846@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Fri, Feb 29, 2008 at 10:24 AM, Phil Hochstetler
> <Phil.Hochstetler@serveron.com> wrote:
>   
>> I guess what I am looking for is advise on the lowest risk, easiest to set
>> up environment to setup that will just work.  Also advise on which kernel to
>> use.   I don't need a detailed tutorial but a high level direct that is
>> known to work.  I am thinking of using either the secret lab tree or the
>> Xilinx tree as recommended in Grants wiki page.  Should I just forget using
>> XP and install a Linux (x86 processor so I must use cross tools)?   If so,
>> what is the recommend distro and what version?
>>     
>
> Yes, absolutely.  Going down the cygwin path is doable, but it is a
> path of pain.  I strongly recommend using a Linux host.  (I personally
> use Ubuntu, but you should have good success with any disto.  Use what
> you're most comfortable with).
>
> The simplest approach to get running with a Linux box is to install
> either VirtualBox or VMware and create yourself a Linux virtual
> machine.  That will get you up and running without having to obtain
> new hardware or risk breaking your XP setup.
>   
    Mostly I would agree - however, I would suggest something like
colinux rather than
    virtualbox or vmware - If you must do development work on a windows
system.
    Colinux is fairly trivial to get up and running.
    It gives you real linux running as a process under windows.
    There is no "virtualization" going on at all.
    The only caveat is that all access to host hardware must go through
windows.
    This is much less of a big deal than it sounds - if you are talking
about a development environment.
    It is also useful because from colinux running under windows you can
have access to your windows filesystem.
    This means that you can use REAL linux tool fairly transparently on
windows while still running windows.
    I rarely run windows anymore. But when I do I run colinux, and I
write linux shell scripts that run under colinux
    to preform tasks I find difficult to do under windows.



-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
