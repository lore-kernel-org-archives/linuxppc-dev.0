Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 03EE3DDE36
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Dec 2007 01:55:09 +1100 (EST)
To: niklaus.giger@member.fsf.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Problem compiling sequoia using DENX kernel. Xenomai-patch
	required?
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 04 Dec 2007 23:14:38 +0100."
	<200712042314.38498.niklaus.giger@member.fsf.org>
Date: Thu, 06 Dec 2007 15:55:06 +0100
Sender: wd@denx.de
Message-Id: <20071206145506.4C81A2430C@gemini.denx.de>
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

In message <200712042314.38498.niklaus.giger@member.fsf.org> you wrote:
> Am Dienstag, 4. Dezember 2007 schrieb Wolfgang Denk:
> <...>
> > I'm afraid "normal" here still means arch/ppc  -  hopefully  for  not
> > long any more. Note: a matching Xenomai patch for arch/ppc will be in
> > Xenomai 2.4 when it comes out in a few days.
> Thanks a lot for your explanation. I took 
> ksrc/arch/powerpc/patches/adeos-ipipe-2.6.23-ppc-1.6-00.patch 
> from the xenomai trunk and was able to compile and boot successfully
> the yosemite board (using ARCH=ppc). Will try the sequoaia board tomorrow.
> 
> I hope that this is a good starting point to get my custom PPC440EPx board 
> into shape. I think once the arch/powerpc will work for PPC440 it should not 
> be a lot of work to port it from ppc -> powerpc.

Actually the arch/powerpc tree is working fine here, too.

You might have been unlucky and cloning / pulling  our  tree  at  the
wrong time; we had a stale DENX-v2.6.23.9 tag in there for some time;
unfortunately  the  fix  doesn't  propagate  as  your  side thinks it
already has a valid tag.

Please either "rm .git/refs/tags/DENX-v2.6.23.9" and pull  again,  or
throw  away  the  whole  tree  and  clone again. Sorry for the incon-
venience. And please let me know if this helps (it should).

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
One of the advantages of being a captain is being able to ask for ad-
vice without necessarily having to take it.
	-- Kirk, "Dagger of the Mind", stardate 2715.2
