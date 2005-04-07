Return-Path: <eamunoz@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.132])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E33A067B1A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Apr 2005 05:56:41 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e34.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j37JuZ5b304656
	for <linuxppc-embedded@ozlabs.org>; Thu, 7 Apr 2005 15:56:35 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j37JuZNh205232
	for <linuxppc-embedded@ozlabs.org>; Thu, 7 Apr 2005 13:56:35 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	j37JuZQL010886
	for <linuxppc-embedded@ozlabs.org>; Thu, 7 Apr 2005 13:56:35 -0600
Received: from d03nm691.boulder.ibm.com (d03nm691.boulder.ibm.com
	[9.17.195.60])
	by d03av03.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	j37JuZDh010883
	for <linuxppc-embedded@ozlabs.org>; Thu, 7 Apr 2005 13:56:35 -0600
To: linuxppc-embedded@ozlabs.org
Message-ID: <OFBEBF187E.5BDC9AA1-ON87256FDC.006D71EC-86256FDC.006E4252@us.ibm.com>
From: Eduardo Munoz <eamunoz@us.ibm.com>
Date: Thu, 7 Apr 2005 14:58:16 -0500
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=08BBE54FDFFEF77C8f9e8a93df938690918c08BBE54FDFFEF77C"
Subject: undefined reference to `zs_kgdb_
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0__=08BBE54FDFFEF77C8f9e8a93df938690918c08BBE54FDFFEF77C
Content-type: text/plain; charset=US-ASCII





Hey!!

I am trying to compile my ppc  kernel 2.6 with KGDB enable and it fails
with the following message:

LD      .tmp_vmlinux1
arch/ppc/platforms/built-in.o(.init.text+0xfc4): In function
`pmac_setup_arch':
arch/ppc/platforms/pmac_setup.c:301: undefined reference to `zs_kgdb_hook'
make: *** [.tmp_vmlinux1] Error 1
error: Bad exit status from /var/tmp/rpm-tmp.40235 (%build)

I am sure you have seen this!
Any ideas how to fix it??

Regards,
Eduardo A. Munoz
eamunoz@us.ibm.com
512-838-8219

--0__=08BBE54FDFFEF77C8f9e8a93df938690918c08BBE54FDFFEF77C
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p>Hey!!<br>
<br>
I am trying to compile my ppc  kernel 2.6 with KGDB enable and it fails with the following message: <br>
<br>
LD      .tmp_vmlinux1<br>
arch/ppc/platforms/built-in.o(.init.text+0xfc4): In function `pmac_setup_arch':<br>
arch/ppc/platforms/pmac_setup.c:301: undefined reference to `zs_kgdb_hook'<br>
make: *** [.tmp_vmlinux1] Error 1<br>
error: Bad exit status from /var/tmp/rpm-tmp.40235 (%build)<br>
<br>
I am sure you have seen this! <br>
Any ideas how to fix it??<br>
<br>
Regards,<br>
Eduardo A. Munoz<br>
eamunoz@us.ibm.com<br>
512-838-8219<br>
<br>
</body></html>
--0__=08BBE54FDFFEF77C8f9e8a93df938690918c08BBE54FDFFEF77C--
