Return-Path: <wd@denx.de>
Received: from mailout11.sul.t-online.com (mailout11.sul.t-online.com
	[194.25.134.85]) by ozlabs.org (Postfix) with ESMTP id 33C2167A79
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jul 2005 05:50:44 +1000 (EST)
To: Nick Barendt <nbarendt@vxitech.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 11 Jul 2005 13:41:26 EDT."
	<42D2AF46.9000200@vxitech.com>
Date: Mon, 11 Jul 2005 21:46:31 +0200
Sender: wd@denx.de
Message-Id: <20050711194631.C30EB3539FE@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 Rev. B 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <42D2AF46.9000200@vxitech.com> you wrote:
>
> I can confirm that there are engineering samples of at least the first 
> mask set of the Rev. B part floating around.  A friend sent me one:
...
> We have had very limited success with the Rev B engineering part, 

We, too, have some problems with hardware which  uses  the  currently
available negineering samples. It's not completely clear if these are
board or processor or software issues yet.

> We do know that there are still errata on the first mask rev and that a 
> second mask rev is in process.
> 
> Anyone else have anything to report?

If you got samples, you should also have access to the updated errata
sheet (MPC5200B_Customer_Info_addendum_errata). Read  it.  Also  note
that you have to use BAPI v2.2 with Rev. B processors.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Every program has at least one bug and can be shortened by  at  least
one  instruction  --  from  which,  by induction, one can deduce that
every program can be reduced to one instruction which doesn't work.
