Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 0EE55DDF60
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Apr 2007 14:41:52 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so911832ugf
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 29 Apr 2007 21:41:50 -0700 (PDT)
Message-ID: <528646bc0704292141n322c145cmc3d2606b13b0b053@mail.gmail.com>
Date: Sun, 29 Apr 2007 22:41:50 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Peter Korsgaard" <peter.korsgaard@barco.com>
Subject: Re: [PATCH 2/5] [PPC] Merge common virtex header files
In-Reply-To: <87slai5vz3.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1176622062492-git-send-email-grant.likely@secretlab.ca>
	<11766220692537-git-send-email-grant.likely@secretlab.ca>
	<11766220693636-git-send-email-grant.likely@secretlab.ca>
	<87d51sac8l.fsf@sleipner.barco.com>
	<528646bc0704271149w211bd5cbscb467123ab962703@mail.gmail.com>
	<87slai5vz3.fsf@sleipner.barco.com>
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

On 4/29/07, Peter Korsgaard <peter.korsgaard@barco.com> wrote:
> >>>>> "GL" == Grant Likely <grant.likely@secretlab.ca> writes:
>
> Hi,
>
> >> instead? I'm using RedBoot on a virtex platform, and hence another
> >> struct bd_info than the ML300/ML403.
>
> GL> Alternate suggestion: Can we change virtex support to use the
> GL> structure defined in ppcboot.h instead?  (I've actually got that
> GL> change in my tree and was planning on posting it for review today
> GL> or tomorrow).  bd_t is a stinking ugly mess, but things would be
> GL> better if we standardize all virtex platforms on the stinking ugly
> GL> mess shared by almost all the other ppc embedded board ports.
>
> That's where the ugly mess pops up - RedBoot uses another
> (incompatible) bd_t definition than U-boot, E.G:

Is the redboot bd_info structure already in the kernel tree?  We could
use a config option to select between the u-boot and redboot
structures for all virtex platforms.  That would keep the uglyness
down to a minimum.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
