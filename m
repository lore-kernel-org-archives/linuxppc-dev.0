Return-Path: <rbaxter@CURTISSWRIGHT.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 8 Jun 2005 06:45:31 -0700
Message-ID: <2A059D6F07F8054294EFC0BD7808FC6D3BE3F5@sdgexch01>
From: "Baxter, Robert" <rbaxter@CURTISSWRIGHT.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: RE: Getting ownership for various boards/platforms configs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Paul Mackerras [mailto:paulus@samba.org]=20
> Sent: Tuesday, June 07, 2005 9:43 PM
> To: Baxter, Robert
> Cc: Linux PPC Embedded list; linuxppc-dev list
> Subject: RE: Getting ownership for various boards/platforms configs
>=20
> Baxter, Robert writes:
>=20
> > > gemini
> >=20
> > I'll take this one.
>=20
> Great!  There are some changes to head.S that I have been wanting to
> make for a while: specifically I want to remove the special case for
> starting the second processor on gemini and the call to
> gemini_prom_init.
>=20
> Does current 2.6 work on gemini?
>=20
> Paul.
>=20

Yes, you may remove the special case for starting the second processor
and the call to gemini_prom_init.  I'm currenting in the middle of
getting our stuff over to 2.6, so the current answer would be no.

--
-Rob
