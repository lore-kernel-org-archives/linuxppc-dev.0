Return-Path: <evilninja@gmx.net>
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 33F7C67A6B
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Mar 2005 03:34:16 +1100 (EST)
Message-ID: <423319FF.8090906@gmx.net>
Date: Sat, 12 Mar 2005 17:34:07 +0100
From: Christian <evilninja@gmx.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
References: <A79EE6739F2C7348A857541FB5CD92D6011566F6@asimail1.rb.uav.com>
In-Reply-To: <A79EE6739F2C7348A857541FB5CD92D6011566F6@asimail1.rb.uav.com>
Content-Type: text/plain; charset=UTF-8
Cc: "Brian V. Madzarevic" <Brian.Madzarevic@uav.com>
Subject: Re: 2.6.11 prep image on radstone ppc4a not booting
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Brian V. Madzarevic wrote:
> Setting PCI interrupts for a "Blackhawk (Powerstack)"
> PCI: Cannot allocate resource region 0 of device 0000:00:0b.1
[...]

i don't know about these, hopefully the ppc gurus could explain these
messages.

> Linux Tulip driver version 1.1.13 (May 11, 2002)
> tulip0:  EEPROM default media type Autosense.
- --^

did you try the de4x5 driver instead of the tulip one? if not...

> CONFIG_NET_TULIP=y
> # CONFIG_DE2104X is not set
> CONFIG_TULIP=y
> # CONFIG_TULIP_MWI is not set
> # CONFIG_TULIP_MMIO is not set
> # CONFIG_TULIP_NAPI is not set
> # CONFIG_DE4X5 is not set
- ----^
here it is ;)
could be worth a try.

Christian.
- --
BOFH excuse #80:

That's a great computer you have there; have you considered how it would
work as a BSD machine?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCMxn/C/PVm5+NVoYRAk1mAKCKCWXxlrHg031uktVx4BxtEMwePACg4hDq
muiR9Exk06I4vS0Xb4L4S3w=
=dqrh
-----END PGP SIGNATURE-----
