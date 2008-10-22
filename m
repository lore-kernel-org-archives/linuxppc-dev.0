Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E7FC7DDEFA
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 10:41:50 +1100 (EST)
Received: from ash.ozlabs.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 14C52368006
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 10:41:49 +1100 (EST)
Date: Thu, 23 Oct 2008 10:41:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: ppc64_defconfig build warnings
Message-Id: <20081023104140.d2839440.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__23_Oct_2008_10_41_40_+1100_Gv4XlwGi8webn73d"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__23_Oct_2008_10_41_40_+1100_Gv4XlwGi8webn73d
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Things are getting better.  Here are the messages from a ppc64_defconfig
build this morning (Linus' tree plus a merge of DaveM's pending network
tree):

kernel/trace/ring_buffer.c: In function 'rb_add_time_stamp':
kernel/trace/ring_buffer.c:969: warning: format '%llu' expects type 'long l=
ong unsigned int', but argument 2 has type 'u64'
kernel/trace/ring_buffer.c:969: warning: format '%llu' expects type 'long l=
ong unsigned int', but argument 3 has type 'u64'
kernel/trace/ring_buffer.c:969: warning: format '%llu' expects type 'long l=
ong unsigned int', but argument 4 has type 'u64'
kernel/cgroup.c: In function 'cgroup_tasks_start':
kernel/cgroup.c:2107: warning: unused variable 'i'

(The above one already has a fix patch pending)

drivers/scsi/ibmvscsi/ibmvfc.c: In function 'ibmvfc_reset_device':
drivers/scsi/ibmvscsi/ibmvfc.c:1630: warning: 'evt' may be used uninitializ=
ed in this function
fs/xfs/xfs_bmap_btree.c: In function 'xfs_bmbt_insrec':
fs/xfs/xfs_bmap_btree.c:702: warning: 'nrec.l0' may be used uninitialized i=
n this function
drivers/scsi/scsi_transport_iscsi.c: In function 'iscsi_add_session':
drivers/scsi/scsi_transport_iscsi.c:704: warning: 'err' may be used uniniti=
alized in this function
WARNING: modpost: Found 12 section mismatch(es).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__23_Oct_2008_10_41_40_+1100_Gv4XlwGi8webn73d
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkj/ujQACgkQjjKRsyhoI8yBcQCdH26my5jeaNUQsq0C2nc7TNFv
NugAoJrTS6oQEKclTDydIqZvTgeLjHFo
=kJ56
-----END PGP SIGNATURE-----

--Signature=_Thu__23_Oct_2008_10_41_40_+1100_Gv4XlwGi8webn73d--
