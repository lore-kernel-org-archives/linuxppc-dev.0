Message-ID: <19990521203719.44590@ibrium.se>
Date: Fri, 21 May 1999 20:37:19 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: Mac-on-Linux
References: <19990519235050.60265@ibrium.se> <Pine.LNX.3.96.990519210752.5706A-100000@EdMcMan.Dyn.Ez-Ip.Net> <19990520192459.17170@ibrium.se> <19990520171823.A409@jasons.dyn.kpn.cx> <87zp2ysaku.fsf@hades.nocrew.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87zp2ysaku.fsf@hades.nocrew.net>; from Stefan Berndtsson on Fri, May 21, 1999 at 05:32:01PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks for the testing! My directions were bad though.
I missed the fact that the kernel source uses #ifdef 
and not #if, so the line

#define NO_RELOAD_HTAB 1

should be commented out in 'arch/ppc/kernel/head.S' and
'arch/ppc/mm/init.c'.

I've looked through the Mac-on-Linux kernel source, and I 
think this should be sufficient to add support for the 603.
(There is a 603 incompatible function used by the debugger, 
but I don't think it is used normally.)

/Samuel


----------------------------------------------------------
 E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
  Phone/fax: (home) +46 8 4418431, (work) +46 8 7908470   
----------------------------------------------------------

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
