Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-39.bluehost.com (outbound-mail-39.bluehost.com
	[69.89.20.193]) by ozlabs.org (Postfix) with SMTP id 9098ADDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 10:25:57 +1100 (EST)
Message-ID: <49C2D2F0.7050005@dlasys.net>
Date: Thu, 19 Mar 2009 19:19:12 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: C67x00 reset problems
References: <49B1469B.9030609@gmail.com>	<1236379543.13132.10.camel@md40100b.ft>
	<49B6F513.2090304@gmail.com>
	<fa686aa40903101642l20d4d3e1qab1eac14493690f1@mail.gmail.com>
In-Reply-To: <fa686aa40903101642l20d4d3e1qab1eac14493690f1@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, "A. Nolson" <alohanono@gmail.com>
Reply-To: dhlii@dlasys.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

    I have been using the mainline c67x00 driver on our boards for a while.

    I am running 2.6.26-rc4 - basically the last arch/ppc version.
    I can only detect devices on the first port of the first host but
otherwise it has been working.  



Grant Likely wrote:
> Unfortunately, the 2.6.24-rc3 stuff in my git tree is really old.
> I've been getting all of my recent work into mainline.  The CF driver
> is in much better shape there.  The c67x00 driver is merged into
> mainline, but I haven't tested it at all in the last year so I don't
> know how well it will work.
>
> Cheers,
> g.


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
