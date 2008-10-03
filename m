Return-Path: <elbert@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 754DFDDF6E
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 01:03:38 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id m93F0wxG026533
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Oct 2008 11:00:58 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m93F3YO9282814
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Oct 2008 11:03:34 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m93F3Ym5025971
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Oct 2008 11:03:34 -0400
Received: from d01mlc04.pok.ibm.com (d01mlc04.pok.ibm.com [9.56.228.37])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m93F3Xqt025946
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Oct 2008 11:03:33 -0400
Subject: ehea: Error in ehea_treat_poll_error: CQE Error for QP 16
To: linuxppc-dev@ozlabs.org
Message-ID: <OFC28D46A6.CBC04B8E-ON852574D7.0050523B-852574D7.0052B90B@us.ibm.com>
From: Elbert C Hu <elbert@us.ibm.com>
Date: Fri, 3 Oct 2008 11:03:34 -0400
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=0ABBFE44DFC3D4AB8f9e8a93df938690918c0ABBFE44DFC3D4AB"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0__=0ABBFE44DFC3D4AB8f9e8a93df938690918c0ABBFE44DFC3D4AB
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable






System log shows a lot of "ehea: Error", see below, during system start=
 up.
Not sure what it is. I'd like to understand this, could someone points =
me
the direction? My "Machine Type and Model ... ST9146802SS" reported fro=
m
lscfg (p6 blade). OS is RHEL 5.2. Kernel level is 2.6.18-92.1.10.el5.

Thanks.

E. Hu
************ ehea.modinfo ************
filename:       /lib/modules/2.6.18-92.1.10.el5/kernel/drivers/net/ehea=
/ehea.ko
version:        EHEA_0076-05
description:    IBM eServer HEA Driver.
author:         Christoph Raisch <raisch@de.ibm.com>
license:        GPL
srcversion:     C481DB79B4694F406CF4AA7
depends:
vermagic:       2.6.18-92.1.10.el5 SMP mod_unload gcc-4.1
parm:           num_tx_qps:Number of TX-QPS (int)
parm:           msg_level:msg_level (int)
parm:           prop_carrier_state:Propagate carrier state of physical =
port
to stack. 1:yes, 0:no.  Default =3D 0  (int)
parm:           rq3_entries:Number of entries for Receive Queue 3 [2^x =
-
1], x =3D [6..14]. Default =3D 1023) (int)
parm:           rq2_entries:Number of entries for Receive Queue 2 [2^x =
-
1], x =3D [6..14]. Default =3D 1023) (int)
parm:           rq1_entries:Number of entries for Receive Queue 1 [2^x =
-
1], x =3D [6..14]. Default =3D 4095) (int)
parm:           sq_entries: Number of entries for the Send Queue  [2^x =
-
1], x =3D [6..14]. Default =3D 1023) (int)
parm:           use_mcs: 0:NAPI, 1:Multiple receive queues, Default =3D=
 0
(int)
parm:           lro_max_aggr: LRO: Max packets to be aggregated. Defaul=
t =3D
64 (int)..
parm:           use_lro: Large Receive Offload, 1: enable, 0: disable,
Default =3D 0 (int).
module_sig:
883f3504886ebc8736cb7d2578e3b1112b7ab09e3b2c69b141d16d1bbbd51ab063f7955=
335a49e80a0ba218c849673e067f7c0ccc9d7353cc1ce05997

************ system log ************
Sep 29 09:35:35 newhamburg kernel: ehea: Error in ehea_treat_poll_error=
:
CQE Error for QP 16
Sep 29 09:35:35 newhamburg kernel: ehea CQE adr=3Dc0000001ddbc1400 ofs=3D=
0000
0000000000000000 200040000000008e
Sep 29 09:35:35 newhamburg kernel: ehea CQE adr=3Dc0000001ddbc1410 ofs=3D=
0010
0000d6ec002a0000 0400000000000000
Sep 29 09:35:35 newhamburg kernel: ehea CQE adr=3Dc0000001ddbc1420 ofs=3D=
0020
0000000000000000 0000000000000000
Sep 29 09:35:35 newhamburg kernel: ehea CQE adr=3Dc0000001ddbc1430 ofs=3D=
0030
0000000000000000 0000000000000000
Sep 29 09:40:10 newhamburg kernel: ehea: Error in ehea_treat_poll_error=
:
CQE Error for QP 16
Sep 29 09:40:10 newhamburg kernel: ehea CQE adr=3Dc0000001dd9d2800 ofs=3D=
0000
0000000000000000 200040000000008e
Sep 29 09:40:10 newhamburg kernel: ehea CQE adr=3Dc0000001dd9d2810 ofs=3D=
0010
0000d6ec002a0000 0800000000000000
Sep 29 09:40:10 newhamburg kernel: ehea CQE adr=3Dc0000001dd9d2820 ofs=3D=
0020
0000000000000000 0000000000000000
Sep 29 09:40:10 newhamburg kernel: ehea CQE adr=3Dc0000001dd9d2830 ofs=3D=
0030
0000000000000000 0000000000000000
Sep 29 10:08:17 newhamburg kernel: ehea: Error in ehea_treat_poll_error=
:
CQE Error for QP 16
Sep 29 10:08:17 newhamburg kernel: ehea CQE adr=3Dc0000001dd9eb600 ofs=3D=
0000
0000000000000000 200040000000008e
Sep 29 10:08:17 newhamburg kernel: ehea CQE adr=3Dc0000001dd9eb610 ofs=3D=
0010
0000d6ec002a0000 0600000000000000
Sep 29 10:08:17 newhamburg kernel: ehea CQE adr=3Dc0000001dd9eb620 ofs=3D=
0020
0000000000000000 0000000000000000
Sep 29 10:08:17 newhamburg kernel: ehea CQE adr=3Dc0000001dd9eb630 ofs=3D=
0030
0000000000000000 0000000000000000
Sep 29 10:21:51 newhamburg kernel: ehea: Error in ehea_treat_poll_error=
:
CQE Error for QP 16
Sep 29 10:21:51 newhamburg kernel: ehea CQE adr=3Dc0000001dd9e2300 ofs=3D=
0000
0000000000000000 200040000000008e
Sep 29 10:21:51 newhamburg kernel: ehea CQE adr=3Dc0000001dd9e2310 ofs=3D=
0010
0000d6ec002a0000 0300000000000000
Sep 29 10:21:51 newhamburg kernel: ehea CQE adr=3Dc0000001dd9e2320 ofs=3D=
0020
0000000000000000 0000000000000000
Sep 29 10:21:51 newhamburg kernel: ehea CQE adr=3Dc0000001dd9e2330 ofs=3D=
0030
0000000000000000 0000000000000000
Sep 29 16:16:23 newhamburg kernel: ehea: Error in ehea_treat_poll_error=
:
CQE Error for QP 16
Sep 29 16:16:23 newhamburg kernel: ehea CQE adr=3Dc0000001ddb9a800 ofs=3D=
0000
0000030002630000 40804000000000e0
Sep 29 16:16:23 newhamburg kernel: ehea CQE adr=3Dc0000001ddb9a810 ofs=3D=
0010
0000e10f002a0000 0800000000000000
Sep 29 16:16:23 newhamburg kernel: ehea CQE adr=3Dc0000001ddb9a820 ofs=3D=
0020
0000000000000000 0000000000000000
Sep 29 16:16:23 newhamburg kernel: ehea CQE adr=3Dc0000001ddb9a830 ofs=3D=
0030
0000000000000000 0000000000000000
Sep 29 21:50:04 newhamburg kernel: ehea: Error in ehea_treat_poll_error=
:
CQE Error for QP 16
Sep 29 21:50:04 newhamburg kernel: ehea CQE adr=3Dc0000001dd9c0700 ofs=3D=
0000
0000000000000000 2080400000000076
Sep 29 21:50:04 newhamburg kernel: ehea CQE adr=3Dc0000001dd9c0710 ofs=3D=
0010
0000fb42002a0000 0700000000000000
Sep 29 21:50:04 newhamburg kernel: ehea CQE adr=3Dc0000001dd9c0720 ofs=3D=
0020
0000000000000000 0000000000000000
Sep 29 21:50:04 newhamburg kernel: ehea CQE adr=3Dc0000001dd9c0730 ofs=3D=
0030
0000000000000000 0000000000000000
Sep 30 03:55:49 newhamburg kernel: ehea: Error in ehea_treat_poll_error=
:
CQE Error for QP 16
Sep 30 03:55:49 newhamburg kernel: ehea CQE adr=3Dc0000001ddb4f900 ofs=3D=
0000
0000000000000000 2000400000000076
Sep 30 03:55:49 newhamburg kernel: ehea CQE adr=3Dc0000001ddb4f910 ofs=3D=
0010
0000fb42002a0000 0900000000000000
Sep 30 03:55:49 newhamburg kernel: ehea CQE adr=3Dc0000001ddb4f920 ofs=3D=
0020
0000000000000000 0000000000000000
Sep 30 03:55:49 newhamburg kernel: ehea CQE adr=3Dc0000001ddb4f930 ofs=3D=
0030
0000000000000000 0000000000000000
Sep 30 09:12:02 newhamburg kernel: ehea: Error in ehea_treat_poll_error=
:
CQE Error for QP 16
Sep 30 09:12:02 newhamburg kernel: ehea CQE adr=3Dc0000001ddbd6400 ofs=3D=
0000
0000000000000000 208040000000008e
Sep 30 09:12:02 newhamburg kernel: ehea CQE adr=3Dc0000001ddbd6410 ofs=3D=
0010
0000d6ec002a0000 0400000000000000
Sep 30 09:12:02 newhamburg kernel: ehea CQE adr=3Dc0000001ddbd6420 ofs=3D=
0020
0000000000000000 0000000000000000
Sep 30 09:12:02 newhamburg kernel: ehea CQE adr=3Dc0000001ddbd6430 ofs=3D=
0030
0000000000000000 0000000000000000=

--0__=0ABBFE44DFC3D4AB8f9e8a93df938690918c0ABBFE44DFC3D4AB
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p>System log shows a lot of &quot;ehea: Error&quot;, see below, during=
 system start up. Not sure what it is. I'd like to understand this, cou=
ld someone points me the direction? My &quot;Machine Type and Model ...=
 ST9146802SS&quot; reported from lscfg (p6 blade). OS is RHEL 5.2. Kern=
el level is 2.6.18-92.1.10.el5. <br>
<br>
Thanks.<br>
<br>
E. Hu<br>
************ ehea.modinfo ************<br>
filename:       /lib/modules/2.6.18-92.1.10.el5/kernel/drivers/net/ehea=
/ehea.ko<br>
version:        EHEA_0076-05<br>
description:    IBM eServer HEA Driver<br>
author:         Christoph Raisch &lt;raisch@de.ibm.com&gt;<br>
license:        GPL<br>
srcversion:     C481DB79B4694F406CF4AA7<br>
depends:        <br>
vermagic:       2.6.18-92.1.10.el5 SMP mod_unload gcc-4.1<br>
parm:           num_tx_qps:Number of TX-QPS (int)<br>
parm:           msg_level:msg_level (int)<br>
parm:           prop_carrier_state:Propagate carrier state of physical =
port to stack. 1:yes, 0:no.  Default =3D 0  (int)<br>
parm:           rq3_entries:Number of entries for Receive Queue 3 [2^x =
- 1], x =3D [6..14]. Default =3D 1023) (int)<br>
parm:           rq2_entries:Number of entries for Receive Queue 2 [2^x =
- 1], x =3D [6..14]. Default =3D 1023) (int)<br>
parm:           rq1_entries:Number of entries for Receive Queue 1 [2^x =
- 1], x =3D [6..14]. Default =3D 4095) (int)<br>
parm:           sq_entries: Number of entries for the Send Queue  [2^x =
- 1], x =3D [6..14]. Default =3D 1023) (int)<br>
parm:           use_mcs: 0:NAPI, 1:Multiple receive queues, Default =3D=
 0  (int)<br>
parm:           lro_max_aggr: LRO: Max packets to be aggregated. Defaul=
t =3D 64 (int)<br>
parm:           use_lro: Large Receive Offload, 1: enable, 0: disable, =
Default =3D 0 (int)<br>
module_sig:	883f3504886ebc8736cb7d2578e3b1112b7ab09e3b2c69b141d16d1bbbd=
51ab063f7955335a49e80a0ba218c849673e067f7c0ccc9d7353cc1ce05997<br>
<br>
************ system log ************<br>
Sep 29 09:35:35 newhamburg kernel: ehea: Error in ehea_treat_poll_error=
: CQE Error for QP 16<br>
Sep 29 09:35:35 newhamburg kernel: ehea CQE adr=3Dc0000001ddbc1400 ofs=3D=
0000 0000000000000000 200040000000008e<br>
Sep 29 09:35:35 newhamburg kernel: ehea CQE adr=3Dc0000001ddbc1410 ofs=3D=
0010 0000d6ec002a0000 0400000000000000<br>
Sep 29 09:35:35 newhamburg kernel: ehea CQE adr=3Dc0000001ddbc1420 ofs=3D=
0020 0000000000000000 0000000000000000<br>
Sep 29 09:35:35 newhamburg kernel: ehea CQE adr=3Dc0000001ddbc1430 ofs=3D=
0030 0000000000000000 0000000000000000<br>
Sep 29 09:40:10 newhamburg kernel: ehea: Error in ehea_treat_poll_error=
: CQE Error for QP 16<br>
Sep 29 09:40:10 newhamburg kernel: ehea CQE adr=3Dc0000001dd9d2800 ofs=3D=
0000 0000000000000000 200040000000008e<br>
Sep 29 09:40:10 newhamburg kernel: ehea CQE adr=3Dc0000001dd9d2810 ofs=3D=
0010 0000d6ec002a0000 0800000000000000<br>
Sep 29 09:40:10 newhamburg kernel: ehea CQE adr=3Dc0000001dd9d2820 ofs=3D=
0020 0000000000000000 0000000000000000<br>
Sep 29 09:40:10 newhamburg kernel: ehea CQE adr=3Dc0000001dd9d2830 ofs=3D=
0030 0000000000000000 0000000000000000<br>
Sep 29 10:08:17 newhamburg kernel: ehea: Error in ehea_treat_poll_error=
: CQE Error for QP 16<br>
Sep 29 10:08:17 newhamburg kernel: ehea CQE adr=3Dc0000001dd9eb600 ofs=3D=
0000 0000000000000000 200040000000008e<br>
Sep 29 10:08:17 newhamburg kernel: ehea CQE adr=3Dc0000001dd9eb610 ofs=3D=
0010 0000d6ec002a0000 0600000000000000<br>
Sep 29 10:08:17 newhamburg kernel: ehea CQE adr=3Dc0000001dd9eb620 ofs=3D=
0020 0000000000000000 0000000000000000<br>
Sep 29 10:08:17 newhamburg kernel: ehea CQE adr=3Dc0000001dd9eb630 ofs=3D=
0030 0000000000000000 0000000000000000<br>
Sep 29 10:21:51 newhamburg kernel: ehea: Error in ehea_treat_poll_error=
: CQE Error for QP 16<br>
Sep 29 10:21:51 newhamburg kernel: ehea CQE adr=3Dc0000001dd9e2300 ofs=3D=
0000 0000000000000000 200040000000008e<br>
Sep 29 10:21:51 newhamburg kernel: ehea CQE adr=3Dc0000001dd9e2310 ofs=3D=
0010 0000d6ec002a0000 0300000000000000<br>
Sep 29 10:21:51 newhamburg kernel: ehea CQE adr=3Dc0000001dd9e2320 ofs=3D=
0020 0000000000000000 0000000000000000<br>
Sep 29 10:21:51 newhamburg kernel: ehea CQE adr=3Dc0000001dd9e2330 ofs=3D=
0030 0000000000000000 0000000000000000<br>
Sep 29 16:16:23 newhamburg kernel: ehea: Error in ehea_treat_poll_error=
: CQE Error for QP 16<br>
Sep 29 16:16:23 newhamburg kernel: ehea CQE adr=3Dc0000001ddb9a800 ofs=3D=
0000 0000030002630000 40804000000000e0<br>
Sep 29 16:16:23 newhamburg kernel: ehea CQE adr=3Dc0000001ddb9a810 ofs=3D=
0010 0000e10f002a0000 0800000000000000<br>
Sep 29 16:16:23 newhamburg kernel: ehea CQE adr=3Dc0000001ddb9a820 ofs=3D=
0020 0000000000000000 0000000000000000<br>
Sep 29 16:16:23 newhamburg kernel: ehea CQE adr=3Dc0000001ddb9a830 ofs=3D=
0030 0000000000000000 0000000000000000<br>
Sep 29 21:50:04 newhamburg kernel: ehea: Error in ehea_treat_poll_error=
: CQE Error for QP 16<br>
Sep 29 21:50:04 newhamburg kernel: ehea CQE adr=3Dc0000001dd9c0700 ofs=3D=
0000 0000000000000000 2080400000000076<br>
Sep 29 21:50:04 newhamburg kernel: ehea CQE adr=3Dc0000001dd9c0710 ofs=3D=
0010 0000fb42002a0000 0700000000000000<br>
Sep 29 21:50:04 newhamburg kernel: ehea CQE adr=3Dc0000001dd9c0720 ofs=3D=
0020 0000000000000000 0000000000000000<br>
Sep 29 21:50:04 newhamburg kernel: ehea CQE adr=3Dc0000001dd9c0730 ofs=3D=
0030 0000000000000000 0000000000000000<br>
Sep 30 03:55:49 newhamburg kernel: ehea: Error in ehea_treat_poll_error=
: CQE Error for QP 16<br>
Sep 30 03:55:49 newhamburg kernel: ehea CQE adr=3Dc0000001ddb4f900 ofs=3D=
0000 0000000000000000 2000400000000076<br>
Sep 30 03:55:49 newhamburg kernel: ehea CQE adr=3Dc0000001ddb4f910 ofs=3D=
0010 0000fb42002a0000 0900000000000000<br>
Sep 30 03:55:49 newhamburg kernel: ehea CQE adr=3Dc0000001ddb4f920 ofs=3D=
0020 0000000000000000 0000000000000000<br>
Sep 30 03:55:49 newhamburg kernel: ehea CQE adr=3Dc0000001ddb4f930 ofs=3D=
0030 0000000000000000 0000000000000000<br>
Sep 30 09:12:02 newhamburg kernel: ehea: Error in ehea_treat_poll_error=
: CQE Error for QP 16<br>
Sep 30 09:12:02 newhamburg kernel: ehea CQE adr=3Dc0000001ddbd6400 ofs=3D=
0000 0000000000000000 208040000000008e<br>
Sep 30 09:12:02 newhamburg kernel: ehea CQE adr=3Dc0000001ddbd6410 ofs=3D=
0010 0000d6ec002a0000 0400000000000000<br>
Sep 30 09:12:02 newhamburg kernel: ehea CQE adr=3Dc0000001ddbd6420 ofs=3D=
0020 0000000000000000 0000000000000000<br>
Sep 30 09:12:02 newhamburg kernel: ehea CQE adr=3Dc0000001ddbd6430 ofs=3D=
0030 0000000000000000 0000000000000000</body></html>=

--0__=0ABBFE44DFC3D4AB8f9e8a93df938690918c0ABBFE44DFC3D4AB--
