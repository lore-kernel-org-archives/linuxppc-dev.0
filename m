Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B31B72BDA6
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 21:27:03 +1000 (EST)
To: "Robert P. J. Day" <rpjday@mindspring.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 21 Sep 2004 07:06:53 EDT."
	<Pine.LNX.4.60.0409210700390.9187@dell.enoriver.com>
Date: Tue, 21 Sep 2004 13:26:55 +0200
Sender: wd@denx.de
Message-Id: <20040921112700.D1DF8C108D@atlas.denx.de>
Cc: Linuxppc-dev mailing list <linuxppc-dev@ozlabs.org>
Subject: Re: thoughts and questions on 8xx patches 
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <Pine.LNX.4.60.0409210700390.9187@dell.enoriver.com> you wrote:
>
> > Why? As far as I understand the I2C/SPI patch has been obsolteted  by
> > the I2C/SPI/SMC1 patch. So only the latter is needed.
> 
> uh huh.  even though, as i've already pointed out, the code in 
> micropatch.c in *both* your source tree and the linuxppc-2.5 tree is 
> broken in that, if you applied the SMC patch, it would have (AFAICT) 
> caused a conflict because of an erroneously low value of RPBASE.
> 
> it's a bit presumptuous to declare that a broken patch has obsoleted 
> one that actually works, don't you think?

You are misinterpreting things. The patch is one thing - it  is  more
or  less  a  black  box  suppied  with usage instructions by the chip
manufacturer. micropatch.c is some code  in  the  Linux  kernel  that
attempts  to  implement the instructions that come with the microcode
patch. The fact that there may be errors in micropatch.c has  nothing
to  do with the fact that one version of the microcode patch may have
obsoleted other versions.

These things have nothing to do with each other.

As  I  alrady  wrote  you  privately  I  think  you  are  right  that
micropatch.c  is  broken  for  the  recent  versions of the microcode
patches. This  does  NOT  mean  that  such  recent  versions  of  the
microcode patches don;t obsolete older versions of the same patches.

Please don;t mix up unrelated things.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A rolling stone gathers momentum.
