Message-ID: <3BAB48AB.2040202@hadess.net>
Date: Fri, 21 Sep 2001 15:03:23 +0100
From: Bastien Nocera <hadess@hadess.net>
Reply-To: hadess@free.fr
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [Fwd: iBook 2001 Internal Modem]
Content-Type: multipart/mixed;
 boundary="------------060509060108020106090203"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------060509060108020106090203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I thought iBook2 owners might be interested. Thanks Mark for allowing me
to post this here.

Cheers

--------------060509060108020106090203
Content-Type: message/rfc822;
 name="Re: iBook 2001 Internal Modem"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: iBook 2001 Internal Modem"


>From hadess  Fri Sep 21 01:50:07 2001
Return-path: <mark_thomas@bigfoot.com>
Envelope-to: hadess@localhost
Delivery-date: Fri, 21 Sep 2001 01:50:07 +0100
Received: from localhost ([127.0.0.1])
	by kara.hadess.net with esmtp (Exim 3.32 #1 (Debian))
	id 15kEW7-0004xQ-00
	for <hadess@localhost>; Fri, 21 Sep 2001 01:50:07 +0100
Delivered-To: online.fr-hadess@free.fr
Received: from imap.free.fr [213.228.0.150]
	by localhost with IMAP (fetchmail-5.9.0)
	for hadess@localhost (single-drop); Fri, 21 Sep 2001 01:50:07 +0100 (BST)
Received: (qmail 32544 invoked from network); 21 Sep 2001 00:50:23 -0000
Received: from 209.249.55.151.voxel.net (HELO octobrx.com) (209.249.55.151)
  by mrelay1-2.free.fr with SMTP; 21 Sep 2001 00:50:23 -0000
Received: (qmail 28957 invoked by uid 1037); 21 Sep 2001 00:52:06 -0000
Delivered-To: hadess-hadess@hadess.net
Received: (qmail 28954 invoked from network); 21 Sep 2001 00:52:06 -0000
Received: from mta01-svc.ntlworld.com (62.253.162.41)
  by 209.249.55.151.voxel.net with SMTP; 21 Sep 2001 00:52:06 -0000
Received: from chip ([62.252.200.176]) by mta01-svc.ntlworld.com
          (InterMail vM.4.01.03.00 201-229-121) with ESMTP
          id <20010921005016.JOGC15984.mta01-svc.ntlworld.com@chip>
          for <hadess@hadess.net>; Fri, 21 Sep 2001 01:50:16 +0100
Received: from mark by chip with local (Exim 3.12 #1 (Debian))
	id 15kEVh-0000pj-00
	for <hadess@hadess.net>; Fri, 21 Sep 2001 01:49:41 +0100
Date: Fri, 21 Sep 2001 01:49:41 +0100
To: Bastien Nocera <hadess@hadess.net>
Subject: Re: iBook 2001 Internal Modem
Message-ID: <20010921014941.A3190@chip>
References: <20010920132016.A1027@chip> <3BAA3E98.90702@hadess.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BAA3E98.90702@hadess.net>; from hadess@hadess.net on Thu, Sep 20, 2001 at 08:08:08PM +0100
From: Mark Thomas <mark_thomas@bigfoot.com>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks for the reply anyway, I have managed to find a solution.  The random=
 garbage I was seemed to be modem speaker data, a quick ATM0 will disable i=
t.  Also to get around the delay in initializing the cobalt modem an init s=
tring of \d\d\d\d\d\dATZ added \d until it works seems to do the trick.

Strange but it seems to work,

Mark

On Thu, Sep 20, 2001 at 08:08:08PM +0100, Bastien Nocera wrote:
> Hi,
>=20
>=20
> Mark Thomas wrote:
> > I have just stumbled across your site online, thanks for the ibook reso=
urces.  I am hoping you may be able to help me with a problem with the inte=
rnal modem.  I have macserial compiled in to the kernel and I can use minic=
om to connect to the modem and send AT commands.  However, if I send ATDTxx=
x I get back a load of gibberish followed by OK.  Do you have any ideas why=
 this may be happening?
> >=20
> > I have also tried using the init string from the modem control script p=
rovided with MacOS but to no avail.
> >=20
> > I would appreciate any help you may be able to give me,
> >=20
> > Mark
>=20
> It appears that the modem is quite different from the previous versions=
=20
> of the iBook. Best is to ask on #mklinux on Openprojects IRC network=20
> (irc.linux.com for example). Benh or Olaf would probably know more on=20
> this issue.
>=20
> Sorry I can't help more.
>=20
> Cheers
>=20
> --=20
> /Bastien Nocera
> http://hadess.net

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature
Content-Disposition: inline


--M9NhX3UHpAaciwkO--

--------------060509060108020106090203--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
