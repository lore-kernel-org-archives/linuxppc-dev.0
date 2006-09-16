Return-Path: <dan@embeddedalley.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id E8448679E0
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2006 02:16:02 +1000 (EST)
In-Reply-To: <20060916183607.94d6facc.sfr@canb.auug.org.au>
References: <20060915213751.128e85f3@localhost.localdomain>
	<20060915173912.7984.40164.stgit@localhost.localdomain>
	<20060916183607.94d6facc.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FF0EF221-284E-4E0A-8576-EFC7E1CE0DE4@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 3/7] POWERPC: Move generic cpm2 stuff to powerpc
Date: Sat, 16 Sep 2006 12:09:34 -0400
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 16, 2006, at 4:36 AM, Stephen Rothwell wrote:

>
>> +	if (brg < 4) {
>> +		bp = (uint *)&cpm2_immr->im_brgc1;
>> +	}
>> +	else {
>
> Normally:
> 	if (brg < 4)
> 		bp = (uint *)&cpm2_immr->im_brgc1;
> 	else {

Sorry, I'm going to nit-pick right back.  This isn't
"normal", it's just your preference.  :-)

When the "else" part contains braces, the "if"
part should as well.  If this get modified and
nested some day in the future, this can cause
a very subtle coding error.

No one should ever be criticized for using too
many braces, provided it is artistically pleasing.

"Normally," the if-else without braces is only
used when there are single statements on
both paths of the logic.  The only exception
is the else-if that emulates a case statement
(when other exceptions also apply, see K&R).

Thanks.

	-- Dan
