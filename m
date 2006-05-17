Return-Path: <mickael_corveller@hotmail.com>
Received: from hotmail.com (bay105-f13.bay105.hotmail.com [65.54.224.23])
	by ozlabs.org (Postfix) with ESMTP id 60055679F5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 May 2006 21:13:54 +1000 (EST)
Message-ID: <BAY105-F13A2DD17F99E4F8DEE34748EA10@phx.gbl>
In-Reply-To: <20060516202600.9181D35363E@atlas.denx.de>
From: "CORVELLER Mickael" <mickael_corveller@hotmail.com>
To: wd@denx.de
Subject: Re: Unable to boot a kernel on a MPC8560
Date: Wed, 17 May 2006 11:13:46 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Reply-To: pito50@hotmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> >
> > first of all, I am a newbie in embedded linux systems.
>
>Seems you are also a newbie when it comes to posting to mailing lists
>in general. Posting  the  same  question  several  times  to  several
>mailing    lists    is    not    a    good    idea.    Please    read
>http://www.catb.org/%7eesr/faqs/smart-questions.html

Indeed, I'm not used to write in mailing lists.

>
>
> > The boot loader is U-Boot.
>...
> > Here is the result of one of my tests :
> > -> niot 0
>...
> > -> nbo 0
>
>These are definitely no U-Boot commands.
>

OK, now I know that my boot loader is not U-Boot, now the question is :
what is the boot loader used by my board ?
I have supposed (certainly wrongly) that the firmware provides on the card 
was based on U-Boot...mea-culpa.

According to you, is it the boot loader the cause of my problem ?

>Best regards,
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
>He's dead, Jim
>	-- McCoy, "The Devil in the Dark", stardate 3196.1
