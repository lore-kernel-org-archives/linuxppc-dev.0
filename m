Message-ID: <008001c43f61$247bb080$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "'Carlo Parravicini'" <c.parravicini@sehitaly.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <762A181C0D966E459A2EB3B810142C770386143A@nmrusdunsx12.nmrlan.net>
Subject: Re: ELDK 3.0 C++ Problem
Date: Fri, 21 May 2004 14:26:30 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I'll bet _two_ cases of beer that Wolfgang won the beer. The seg. fault is
> happening in the memset.
>

Before this goes any further, I think we need to put the beer in escrow.  I
humbly offer my garage.  I will sample it and make sure it's worthy of this
duel.

By the way - on the printf - do you have a '\n' on the end of your
diagnostic message?  If you're right, you're going to have to go the next
step and find out exactly what is failing in new().  'new' should basically
boil down to malloc(4), possibly followed by 'if (p == 0) branch_to_catch',
then *p = 10000;  Hard to imagine what could go wrong there...

Mark Chambers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
