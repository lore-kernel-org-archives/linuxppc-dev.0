Return-Path: <evilninja@gmx.net>
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id CDA722BF24
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jan 2005 02:08:49 +1100 (EST)
Message-ID: <41DAB17E.2080706@gmx.net>
Date: Tue, 04 Jan 2005 16:08:46 +0100
From: Christian <evilninja@gmx.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
References: <41D9FB86.1060407@gmx.net>
	<200501041423.34061.marc.dietrich@ap.physik.uni-giessen.de>
In-Reply-To: <200501041423.34061.marc.dietrich@ap.physik.uni-giessen.de>
Content-Type: text/plain; charset=UTF-8
Cc: Marc Dietrich <Marc.Dietrich@ap.physik.uni-giessen.de>
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
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

Marc Dietrich schrieb:
> 
> So you are using netboot and it seems that when having a root-fs via nfs _no_ 
> disk driver is initialized even if it is compiled in (acording to your 
> config). Funny, didn't know that.
> 

whoops! so, the 2.6.10-rc3 bootlog shows indeed no scsi-initialization -
i'll boot a proper scsi-enabled config then and upload another bootlog ;-)

- --
BOFH excuse #401:

Sales staff sold a product we don't offer.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB2rF+C/PVm5+NVoYRAjkRAKCiSC6zSmw6Rvhy5RAbUtw4yFKvJgCfTMnA
IIfoTniXDIT/YvsORjexf38=
=vX/q
-----END PGP SIGNATURE-----
