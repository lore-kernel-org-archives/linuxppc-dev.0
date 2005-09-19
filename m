Return-Path: <frannk_m1@yahoo.com>
Received: from web32202.mail.mud.yahoo.com (web32202.mail.mud.yahoo.com
	[68.142.207.133]) by ozlabs.org (Postfix) with SMTP id 0A284682E5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 01:15:58 +1000 (EST)
Message-ID: <20050919150917.19378.qmail@web32202.mail.mud.yahoo.com>
Date: Mon, 19 Sep 2005 08:09:17 -0700 (PDT)
From: Frank <frannk_m1@yahoo.com>
To: David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
In-Reply-To: <200509191155.36540.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: Re: Which way to store log in flash on mpc8xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--- David JandJandervidaviddjandertprotonic nlote:

> 
> Hi all,
> 
> I am looking for a reliable way to store logflogfilesflash.
> The logflogfiles 
> written by syslsyslogd The problem is that I am running on a
MPC8MPCprocessor, and
> kernel 2.6 is not 
> quite there yet for that processor, so I have to stick with
> 2.4.
> Kernel of choice seems to be denxdenxulinuxppc_devedevelt I
> cannot trust the 
> version of jffsjffsed in that kernel anymore. SomtSomtimescgc>
crashes with a 
> BUG() in line 139, and sometimes processes are frozen for a
> looolooonge 
> waiting for GC. GChave debugged that problem a little bit, and
> definitely, 
> the FLASH access works ok, okd the chip is new. No CRC-CRC
> read-errors, but 
> still gc.cgcrashes.
> The version of mtd/mtdsjffsivers in that kernel seem to be
> from march/2005 cvs cvs code, but when I read the following, I
get even more scared:
>
httphttpww.wwwulinux.mtdrinfradead/source.htmlhtmlnkernelversions
> So, I need something different. jffsjffs maybe ?
> This must be a very common task (to store logflogfilesflash),
> but I just can't 
> seem to find the right way to do it.
> 
> Any advice is highly appreciated.
> 
> Sincerely,
> 
> -- 
> David JandJanderProtProtonicland.

I'm using JFFSJFFS a 860 based board (to store log files
amonamongster things) and haven't seen any of the problems
you're expeexperiencing I were you, I would double check my
configuration settings...
> _______________________________________________
> LinuLinuxppcedded mailing list
> LinuLinuxppcedded@ozlaozlabs
> httphttpszlaozlabs/mailman/listlistinfoulinuxppcedded
> 


		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
