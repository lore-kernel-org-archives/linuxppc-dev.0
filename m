Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id D9C7BDDEF1
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 23:29:50 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ju6Bs-0003Hz-JY
	for linuxppc-dev@ozlabs.org; Thu, 08 May 2008 13:29:44 +0000
Received: from p5497da3c.dip.t-dialin.net ([84.151.218.60])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 08 May 2008 13:29:44 +0000
Received: from dzu by p5497da3c.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 08 May 2008 13:29:44 +0000
To: linuxppc-dev@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: All your drivers are belong to us
Date: Thu, 08 May 2008 15:28:49 +0200
Message-ID: <m2prrwsz5a.fsf_-_@ohwell.denx.de>
References: <20080504204104.7eea7618@lappy.seanm.ca>
	<1209958719.21644.32.camel@pasglop>
	<20080505004023.05603b93@lappy.seanm.ca>
	<m23aouuqoh.fsf_-_@ohwell.denx.de>
	<20080507174251.2af863d6@wally.pikatech.com>
	<20080507194957.47abb103@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

> On Wed, 7 May 2008 17:42:51 -0400
> Sean MacLennan <smaclennan@pikatech.com> wrote:
>
>> On Wed, 07 May 2008 16:36:30 +0200
>> "Detlev Zundel" <dzu@denx.de> wrote:
>> 
>> > It also happened that a driver once posted for what the customer
>> > thought was a completely specific device of his own today supports
>> > lots of different boards from at least four different manufacturers."
>> > 
>> > The wording is of course not exact but I hope I caught the spirit of
>> > what Greg wanted to say.  So yes, please post the driver - maybe Greg
>> > KH will tunnel it into mainline...
>> 
>> I agree with the sentiment. However, it is hard enough to get
>> legitimate drivers into the kernel. The drivers I mentioned do not
>> come close to following the Linux kernel coding spec.
>
> Here's the cool part.  There's this Linux driver project:
>
> http://www.linuxdriverproject.org/twiki/bin/view
>
> where they can take drivers like that and clean them up.  At least to a
> reasonable degree.  The benefit for you is that once it's cleaned up,
> it can go into the mainline kernel and it will just be there in future
> releases.  Helpful when you update.

Yes, I should have mentioned this also in my original mail.  If I
remember correctly, Greg mentioned that in this project, he has *300*
developers waiting to do something.  None of the companies previously
claiming Linux had a driver problem showed up even when he contacted
them directly....

> Now, I can't say I've personally ever used that project but its mission
> does seem pretty targeted towards groups that want to do the right
> thing with respect to drivers.  Maybe you could give it a shot and tell
> others about the experience.

This would definitely be interesting.

Cheers
  Detlev

-- 
-- Question authority!
-- Yeah, says who?
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
