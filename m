Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 157AD2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 May 2013 10:42:51 +1000 (EST)
Date: Tue, 30 Apr 2013 19:42:38 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
To: Anthony Foiani <tkil@scrye.com>
In-Reply-To: <5180631F.6080106@scrye.com> (from tkil@scrye.com on Tue Apr 30
 19:34:39 2013)
Message-ID: <1367368958.24133.21@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>, Jeff Garzik <jeff@garzik.org>,
 Adrian Bunk <bunk@stusta.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/30/2013 07:34:39 PM, Anthony Foiani wrote:
> Scott --
>=20
> Thanks for the quick reply / review!
>=20
> On 04/30/2013 12:15 PM, Scott Wood wrote:
>> [The devtree approach] might be OK for a new board, but adding it =20
>> now means that people using existing device trees won't get the =20
>> workaround.  It might be better to just put the knowledge in =20
>> platform code.
>=20
> That would be fantastic, if I knew what to test.
>=20
> If you look at the thread from last year, it seems that even there in =20
> Freescale, nobody knows exactly what triggers this.
>=20
> There was the "orphan" config value, and I simply turned that into a =20
> devtree switch.
>=20
> If you can find an answer inside Freescale, I can try to respin the =20
> patch to accommodate that knowledge.  But until then, this is the =20
> best I can do.
>=20
> (And it's not a new board -- it's based on the 8315ERDB, and the =20
> orphaned symbol is apparently related to another 8315 board that =20
> never got released?)

I just meant that, for whatever boards you would have put this in the =20
device tree, put it in platform code instead (if the platform file =20
supports more than one board type, then check the compatible at the top =20
of the device tree).  Or do you mean that you would not set this on any =20
board's device tree by default, and instead have users set it if they =20
encounter problems?  Is this a custom board you're seeing it on?

>> and submit the patch inline rather than as an attachment (e.g. use =20
>> git send-email).
>=20
> Will see if I can do so.  I don't actually have any sort of MTA set =20
> up on this machine, hence these Thunderbirded messages.

git send-email can connect directly to an SMTP server.

-Scott=
