Return-Path: <markc@mail.com>
Received: from relay04.roc.ny.frontiernet.net (relay04.roc.ny.frontiernet.net
	[66.133.131.37]) by ozlabs.org (Postfix) with ESMTP id D69A22BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 06:46:35 +1000 (EST)
Received: from filter02.roc.ny.frontiernet.net
	(filter02.roc.ny.frontiernet.net [66.133.131.177])
	by relay04.roc.ny.frontiernet.net (Postfix) with ESMTP id BCCAF10C20
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Oct 2004 20:46:34 +0000 (UTC)
Received: from relay04.roc.ny.frontiernet.net ([66.133.131.37])
	by filter02.roc.ny.frontiernet.net (filter02.roc.ny.frontiernet.net
	[66.133.131.177]) (amavisd-new, port 10024)
	with LMTP id 06294-18-75 for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Oct 2004 20:46:34 +0000 (UTC)
Received: from chuck2 (170-215-150-62.br1.rmn.wv.frontiernet.net
	[170.215.150.62])
	by relay04.roc.ny.frontiernet.net (Postfix) with ESMTP id 6D5FE10D1C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Oct 2004 20:46:31 +0000 (UTC)
Message-ID: <00d001c4b166$04a06ea0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Embedded PPC Linux list" <linuxppc-embedded@ozlabs.org>
References: <065ACD8E84315E4394C835E398C8D5EB865270@COSSMGMBX02.email.corp.tld>
	<20041013132613.A21277@home.com>
Date: Wed, 13 Oct 2004 16:48:34 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: "I2C" versus "IIC"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> On Wed, Oct 13, 2004 at 02:18:03PM -0600, VanBaren, Gerald (AGRE) wrote:
> > Just to mess with your minds... I2C is a trademark of Philips
> > Electronics N.V. so that is probably not the best choice from a
> > legalistic point of view.
> 
> It's been related to me several times that this is the reason why
> most implementers refer to their interface/bus as IIC in
> documentation.
> 
> -Matt

Assuming this to be true, it still may be a bit misguided.  Using 'i2c' to
refer to a legal implementation is no more illegal than a restaurant
putting 'Coke' on their menu.  What does Philips want?  They want
royalties from implementations of i2c, and they do not want the term
diluted by using it to refer to other similar protocols.  So I don't
think that just changing to 'iic' would pacify them in either of these
cases.  If it's truly i2c I don't think they care what you call your
variables, (just so the chip manufacturer pays up) and if it's not, 
find a completely different name.

Mark C.
