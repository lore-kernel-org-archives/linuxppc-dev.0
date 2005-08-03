Return-Path: <JHughes@Linx.co.uk>
Received: from stives3.stives.linx.gbr (gateway.linx.co.uk [194.131.232.48])
	by ozlabs.org (Postfix) with ESMTP id 694F467E96
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 23:24:24 +1000 (EST)
Message-ID: <DB1B6B12D0E2F0469EB35A9586066B6ECE75FB@stivesemail.stives.linx.gbr>
From: James Hughes <JHughes@Linx.co.uk>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Wed, 3 Aug 2005 14:26:15 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: EST MPC823 board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We already have VXWorks working on the board, so a lot of data can be
gleaned from the BSP for that. As a beginner to U-Boot - would the
information from that be sufficient to get to a working build?

EST were taken over by Windriver some time ago - and given the level of
support we have received from them in the past (hence movement to Linux...)
I am not optimistic of getting information from them regarding an 8 year old
board!

for the list : 
Its difficult to see from the U-Boot tree which boards are based on the
MPC623 - is there a quick way of finding which are? grep for 623?

James

-----Original Message-----
From: 'Aristeu Sergio Rozanski Filho' [mailto:aris@cathedrallabs.org]
Sent: 03 August 2005 14:01
To: James Hughes
Subject: Re: EST MPC823 board


> Did you start from an existing board definition, or have you started from
> scratch?
a good way is to find a similar (supported) board and use it as starting
point. but for this you need your board's datasheet.

> I wasn't able to find a datasheet from the embedded planet site - do you
> have a direct link to it?
please ignore my last post, I didn't read the model correctly

> I am going to email EST to see if they have any information - but since
the
> board is pretty ancient, I am not confident.
if you get the datasheet (you must know things like control registers
address and meaning) it's possible to do it. google a bit too, maybe
someone has it.

-- 
Aristeu



The information contained in this e-mail message (and any attachment
transmitted herewith) is privileged and confidential and is intended for the
exclusive use of the addressee(s). If you are not an addressee, any
disclosure, reproduction, distribution or other dissemination or use of this
communication is strictly prohibited. If you have received this
communication in error, please contact us immediately so that we can correct
the error.
