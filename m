Return-Path: <wd@denx.de>
Received: from mailout11.sul.t-online.com (mailout11.sul.t-online.com
	[194.25.134.85]) by ozlabs.org (Postfix) with ESMTP id E0DBB2BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Nov 2004 08:53:11 +1100 (EST)
To: "Mark Chambers" <markc@mail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 05 Nov 2004 10:09:18 EST."
	<005a01c4c349$7949b8c0$0301a8c0@chuck2>
Date: Fri, 05 Nov 2004 21:47:05 +0100
Sender: wd@denx.de
Message-Id: <20041105204710.735A7C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Handling power failure - MPC5200 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <005a01c4c349$7949b8c0$0301a8c0@chuck2> you wrote:
> 
> >What I've seen is marketing bullet points saying the cards can survive a
> >power loss event with no loss of data, but when I read the >detailed CF
> >specification, the disclaimer was that power had to be held up for X mSec (I
> >forgot what X was, 2mSec or 10mSec most likely) after the last write
> >operation.  The marketing bullet point was exactly that: marketing.  The
> >real requirement levied on the user
> >(you) was that you had to have X mSec power hold up after the last write
> >operation (i.e. a X mSec power fail warning with no write >operations after
> >the PF warning).  The hold-up requirement gave the CF internals enough time
> >to complete a flash write cycle.
> 
> One simple use for the power fail interrupt would be to just turn off
> interrupts and loop until power fail.
> This would insure that a write or erase operation completed fully.

Maybe it would - but do you know exactly how long a  write  operation
will  take?  I  haven't  seen  such information in the specs I had so
far...

Best regards,

Wolfgang Denk

-- 
See us @ Embedded/Electronica Munich, Nov 09 - 12, Hall A.6 Booth 513
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Your own mileage may vary.
