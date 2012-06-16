Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id E1D35100B2B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 11:15:58 +1000 (EST)
Date: Sat, 16 Jun 2012 11:15:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: wfg@linux.intel.com
Subject: Re: [driver-core:driver-core-linus 6/6]
 drivers/firmware/iscsi_ibft_find.o: In function `kmsg_dump_rewind':
 (.text+0x18): multiple definition of `kmsg_dump_rewind'
Message-Id: <20120616111550.597c8f605fa64fb9789fa506@canb.auug.org.au>
In-Reply-To: <4fdbcd2f.Ta8kRp58FRzqrqaL%wfg@linux.intel.com>
References: <4fdbcd2f.Ta8kRp58FRzqrqaL%wfg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Sat__16_Jun_2012_11_15_50_+1000_X+l_IMGM4Q3+5HaU"
Cc: devel@driverdev.osuosl.org, linuxppc-dev@lists.ozlabs.org,
 Kay Sievers <kay@vrfy.org>, linux-mtd@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Sat__16_Jun_2012_11_15_50_+1000_X+l_IMGM4Q3+5HaU
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, 16 Jun 2012 08:02:55 +0800 wfg@linux.intel.com wrote:
>
> Kernel build failed on
>=20
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.=
git driver-core-linus
> head:   e2ae715d66bf4becfb85eb84b7150e23cf27df30
> commit: e2ae715d66bf4becfb85eb84b7150e23cf27df30 [6/6] kmsg - kmsg_dump()=
 use iterator to receive log buffer content
> config: i386-randconfig-usb1 (attached as .config)

Please have a good look at what you are sending out.  I don't understand
why this report has come to linuxppc-dev (the patch touches an
arch/powerpc file, but none of the problems reported are in that file).
You should put the .config on a web site somewhere and include the URL and
you should not include the whole patch (these were all quite large) -
people can find them given a tree and commit (like above).

And you sent out 7 reports for the same patch!

I approved this bunch, but will not (unless pressured) approve any more.
This scatter gun automated approach is like the boy crying wolf.

I appreciate the effort, but please tone down the reports considerably.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Sat__16_Jun_2012_11_15_50_+1000_X+l_IMGM4Q3+5HaU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJP295GAAoJEECxmPOUX5FEXukP/RqNdYHfMJrNksQUGxDL+MxI
2jszmK0fVr5jmZVsUSevJGBLxiDfeK9mDzi8CQfS6N1jbOlpbhVIff/zfrOHGIKY
hulTUhn3F13k36gO4vpXIni8Wf4BkE5wOOaf1P3vyUsrwp2/lxx/rdbTkSgujUkE
wSgu726Fk8UGfVLJszHts3o/pkyZUqJIJ0f3WMY6hz5olimcTp8wRhfcLH4Nh8AB
EB101y2SVyFmwF78UV2hh0Due67Zs7G+ZsTxhyj1ubZfjd9xs4+0YzNysLP6PKjP
O0truECnFsZmQIt1mEqYSlnNy1ML9fE+e+GvO1s9HERt3DjemMPFGYNI1DCs4fIL
SZ8yKsVFTuJ+L0hxAqPfGcfHaFVBwmSkxdtu3HNodeENB6EW+6XXW5GLbW27BW1l
3FoVxS0WAGzzbWht3YTLc+OJu0T17w4nUQ+RrSk0SR6w7sMv6X4a9r7/QUFA1DRn
FTIbTk7K99tv8pAImJ0lXDWKrvZJ6DGPk/GWqZGs1LVIG0Zu8MybzhM+oVyOtpJk
++JPwCVavbil+PtwEtmiLwIfHLOTAHX2F9+CI7n4By2+JobQgbEkZyxcSoGFTnlp
9ZMuafONMWNp1aWpRCFf7MNL+w3c1+SCZmkMp+SrM/LXcP4y77MUz6X+kxKd7mQo
q23RQhQ+5V3AOArdKy/d
=dZrb
-----END PGP SIGNATURE-----

--Signature=_Sat__16_Jun_2012_11_15_50_+1000_X+l_IMGM4Q3+5HaU--
