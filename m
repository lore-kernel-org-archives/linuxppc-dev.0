Return-Path: <annamaya@yahoo.com>
Received: from web53806.mail.yahoo.com (web53806.mail.yahoo.com
	[206.190.36.201]) by ozlabs.org (Postfix) with SMTP id 705C567A79
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jan 2005 09:11:25 +1100 (EST)
Message-ID: <20050119221123.49764.qmail@web53806.mail.yahoo.com>
Date: Wed, 19 Jan 2005 14:11:23 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: Robin <robin@india.tejasnetworks.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <4229EDFB.2040402@india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: TZ variable setting for denx 2.4.20
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am not sure what hapenned to the SPI driver that was
out there for the 8xx that I wrote a long time ago. I
know that it was working fine then. I do have a
version now that works great. I'll try and make it
available somewhere real soon. But this one's only for
the 2.4 kernel and not the 2.6 kernel.

--- Robin <robin@india.tejasnetworks.com> wrote:

> Hi all,
> I am trying to find a way of setting TZ environment
> variable with DST
> support for southern hemisphere countries. Its
> giving a strange problem.
> In southern hemisphere countries, DST starts around
> Oct and ends around
> March. The DST time seems to be applicable from Oct
> until Dec31,19:00hrs.
> Then it reverts back to standard time.
> 
> For northern hemisphere countries, its working
> perfectly.(Here DST starts
> around March and ends around Oct. There is no year
> crossing DST period.)
> 
> I am sending the system timezone at various times..
> 
> bash> export TZ="xxx5:30yyy4:30,M10.1.1,M2.1.1"
> bash> date 10010159
> Mon Oct  1 01:59:00 xxx 2001
> bash> date
> Mon Oct  1 01:59:47 xxx 2001
> bash> date
> Mon Oct  1 03:00:10 yyy 2001
> bash> date 12311900
> Mon Dec 31 19:00:00 yyy 2001
> bash> date 12311959
> Mon Dec 31 18:59:00 xxx 2001 <----------- problem.
> It should have
> reverted to xxx only in feb.
> 
> Please give me some idea for setting time zone for
> southern hemisphere
> countries.
> 
> I am using 2.4.20 linux kernel from denx.I am
> running date command from
> busybox version 0.6 which in is using strftime. The
> processor is ppc860T.
> 
> Regards,
> Robin Mathew
> 
> 
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 



		
__________________________________ 
Do you Yahoo!? 
Take Yahoo! Mail with you! Get it on your mobile phone. 
http://mobile.yahoo.com/maildemo 
