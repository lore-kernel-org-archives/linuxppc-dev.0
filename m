Return-Path: <ben@codiert.org>
Received: from mail.subgra.de (subgra.de [85.10.194.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.subgra.de", Issuer "mail.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8B72EDDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Mar 2007 18:12:09 +1100 (EST)
Date: Mon, 12 Mar 2007 07:42:49 +0100
From: Benjamin Krill <ben@codiert.org>
To: "David H. Lynch Jr" <dhlii@comcast.net>
Subject: Re: compiling withoug glibc
Message-ID: <20070312064248.GA31115@codiert.org>
References: <45F4D72F.8010101@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <45F4D72F.8010101@comcast.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hey,

did you try the options "-nostdlib -nostdinc"?

cheers
 ben

* David H. Lynch Jr | 2007-03-11 23:29:35 [-0500]:

>
>    I have several projects that need to be built using GCC but
>absolutely no external libraries, headers etc.
>    not glibc, not uClibc, nothing.
>
>    I also need to do this under both windows and Linux.
>
>    I have been somewhat successful by renaming directories inside the
>crosscompiler subdirectory so that gcc, ... can't find any standard
>libraries etc.
>
>    But I can not get this to work uniformly accross platforms, and I
>can not trivially reverse it when I do need glibc.
>
>    I have the vaguest clue that doing this has something to do with
>triggering gcc to run through different peices of the "specs" file,
>    but what I can find of documentation is opaque too me.
>
>    A clue would be greatly appreciated.
>
>
>
>
>
>-- 
>Dave Lynch 					  	    DLA Systems
>Software Development:  				         Embedded Linux
>717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
>fax: 1.253.369.9244 			           Cell: 1.717.587.7774
>Over 25 years' experience in platforms, languages, and technologies too numerous to list.
>
>"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
>Albert Einstein
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

-- 
[ Benjamin Krill ][ ben(@)codiert(.)org ][ http://codiert.org ]
