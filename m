Return-Path: <annamaya@yahoo.com>
Received: from web53808.mail.yahoo.com (web53808.mail.yahoo.com
	[206.190.36.203]) by ozlabs.org (Postfix) with SMTP id 552F167A2C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jan 2005 03:44:40 +1100 (EST)
Message-ID: <20050119164438.12359.qmail@web53808.mail.yahoo.com>
Date: Wed, 19 Jan 2005 08:44:37 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: Demke Torsten-atd012 <torsten.demke@motorola.com>,
	linuxppc-embedded@ozlabs.org
In-Reply-To: <43395BE65409D911B9FF00110A9BFFDC9F86EB@zwg57exm01.ea.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: RE: ELDK on a PowerPC host machine?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for the reply Demke. This is exactly how I
managed to get it going on my G4 even before I read
your mail. I am glad that I am on the right trac here.

--- Demke Torsten-atd012 <torsten.demke@motorola.com>
wrote:

> Hi,
> 
> we use the ELDK on G4 here in the following way:
> a) install ELDK on x86
> b) move target directory (the one you would use for
> NFS) to your G4
> c) chroot into that target directory on yout G4
> d) manually mount /proc, setup path, ...
> 
> Compilation of u-boot and Linux Kernel works fine. 
> (tested with 82xx and 8xx).
> 
> Regards,
> Torsten
> 
> 
> 
> > -----Original Message-----
> > From: linuxppc-embedded-bounces@ozlabs.org
> > [mailto:linuxppc-embedded-bounces@ozlabs.org]On
> Behalf Of annamaya
> > Sent: Freitag, 14. Januar 2005 16:52
> > To: linuxppc-embedded@ozlabs.org
> > Subject: ELDK on a PowerPC host machine?
> > 
> > 
> > I noticed that ELDK from denx does not support
> running
> > on a PowerPC host machine like the Power G4 or G5.
> > When I tried rebuilding it on a Power G4 with
> > YellowDog installed on it, it complained that the
> > PowerPC host machine is not supported. Why is this
> > host architecture not supported? I also found out
> that
> > MontaVista does not support the PowerPC host
> > architecture anymore which they did a while ago.
> What
> > seems to be the real reason for not supporting
> this?
> > Thanks for the reply.
> > 
> > 
> > 	
> > 		
> > __________________________________ 
> > Do you Yahoo!? 
> > Yahoo! Mail - You care about security. So do we. 
> > http://promotions.yahoo.com/new_mail
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> >
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > 
> 



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Find what you need with new enhanced search.
http://info.mail.yahoo.com/mail_250
