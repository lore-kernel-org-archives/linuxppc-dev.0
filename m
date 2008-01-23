Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B0C94DDE38
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 23:54:15 +1100 (EST)
To: Marian Balakowicz <m8@semihalf.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] [POWERPC] Update TQM5200,
	CM5200 and Motion-PRO _defconfig and .dts files
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 23 Jan 2008 12:31:48 +0100."
	<479725A4.2020401@semihalf.com>
Date: Wed, 23 Jan 2008 13:54:13 +0100
Sender: wd@denx.de
Message-Id: <20080123125413.EB56924344@gemini.denx.de>
Cc: Olof Johansson <olof@lixom.net>, tech-denx@semihalf.com,
	Detlev Zundel <dzu@denx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <479725A4.2020401@semihalf.com> you wrote:
> Olof Johansson wrote:
> ...
> > 
> > I disagree, I have one defconfig for all our boards to date. It means I
> > only have one kernel to build to test on all boards, instead of having
> > to build a number of different kernels. Keeping it fairly generic also
> > means a customer can start out using the generic kernel in case they
> > want to, and later on add their own drivers and prune out what is not
> > needed.
> 
> Well, I just prefer separate defconfigs but I can live with the common
> one as well, feel free to merge it as you see it fit.

Well, it may make sense to use common defconfig files for  boards  of
the same breed (different configurations of one board family from one
vendor  for  example).  But  please  note  that  TQM5200,  CM5200 and
Motion-PRO are boards from 3 different  vendors,  used  by  different
projects  with  differing  needs.  IMO  it  makes  very much sense to
provide 3 separate default configurations  that  match  the  specific
requirements of each of these boards.

In this case I vote for separate defconfig files, please.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Be careful what you wish for. You never know who will be listening.
                                      - Terry Pratchett, _Soul Music_
