Return-Path: <Gerald.VanBaren@smiths-aerospace.com>
Received: from smtp1.smiths.com (smtp1.smiths.com [192.208.34.50])
	by ozlabs.org (Postfix) with ESMTP id 1CB7B2BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 06:18:32 +1000 (EST)
Received: from COSSMGIMS02.email.corp.tld (unknown [10.225.225.143])
	by smtp1.smiths.com (Postfix) with ESMTP id BA33D1C00BDF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Oct 2004 14:18:27 -0600 (MDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 13 Oct 2004 14:18:03 -0600
Message-ID: <065ACD8E84315E4394C835E398C8D5EB865270@COSSMGMBX02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: "Eugene Surovegin" <ebs@ebshome.net>,
	"Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: RE: "I2C" versus "IIC"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org=0D
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of=0D
> Eugene Surovegin
> Sent: Wednesday, October 13, 2004 3:34 PM
> To: Robert P. J. Day
> Cc: Embedded PPC Linux list
> Subject: Re: "I2C" versus "IIC"
>=0D
> On Wed, Oct 13, 2004 at 02:26:23PM -0400, Robert P. J. Day wrote:
> >=0D
> >   i was just about to rename some of my variables and macros to be=0D
> > consistent with what i *thought* was the standard nomenclature of=0D
> > "IIC" as opposed to "I2C".  just checked include/asm-ppc,=0D
> and grepped=0D
> > for case-insensitive instances of both strings ... oh, god.=0D
>  there's=0D
> > really no preferred usage, is there?
>=0D
> Philips' documentation uses I2C, not IIC, so I guess this is=0D
> _official_ name of the _bus_.
>=0D
> Some vendors (like IBM in their 4xx parts) use IIC to name=0D
> I2C _interface_ to distinguish it from I2C _bus_ (they=0D
> specifically mention this in the chip manual).
>=0D
> For example, in the corresponding 4xx driver I used "iic"=0D
> because it was written for IBM IIC _interface_.
>=0D
> --
> Eugene.


Just to mess with your minds... I2C is a trademark of Philips
Electronics N.V. so that is probably not the best choice from a
legalistic point of view.

gvb



******************************************
The following messages are brought to you by the Lawyers' League of
IdioSpeak:

******************************************
The information contained in, or attached to, this e-mail, may contain=
 confidential information and is intended solely for the use of the=
 individual or entity to whom they are addressed and may be subject to=
 legal privilege.  If you have received this e-mail in error you should=
 notify the sender immediately by reply e-mail, delete the message from=
 your system and notify your system manager.  Please do not copy it for any=
 purpose, or disclose its contents to any other person.  The views or=
 opinions presented in this e-mail are solely those of the author and do=
 not necessarily represent those of the company.  The recipient should=
 check this e-mail and any attachments for the presence of viruses.  The=
 company accepts no liability for any damage caused, directly or=
 indirectly, by any virus transmitted in this email.
******************************************
