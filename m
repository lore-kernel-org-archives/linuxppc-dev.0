Return-Path: <Steven_Lin@notes.teradyne.com>
Received: from newshow.teradyne.com (newshow.teradyne.com [198.51.251.9])
	by ozlabs.org (Postfix) with ESMTP id ECC0AB7196
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Nov 2010 09:13:28 +1100 (EST)
Received: from sunfire.teradyne.com ([131.101.1.179])
	by newshow.teradyne.com (8.11.7p1+Sun/8.10.2) with ESMTP id
	oAHM11821132 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Nov 2010 17:01:01 -0500 (EST)
Received: from jaypeakclust.ter.teradyne.com (jaypeakclust.ter.teradyne.com
	[131.101.182.11])
	by sunfire.teradyne.com (8.13.1/8.13.1) with ESMTP id oAHM3DKF002373
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Nov 2010 17:03:13 -0500
Subject: application needs fast access to physical memory
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <OFEB1252DC.D653C7C7-ON882577DE.0078DABB-862577DE.00792502@notes.teradyne.com>
From: steven.lin@teradyne.com
Date: Wed, 17 Nov 2010 16:03:03 -0600
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=07BBFD4DDFEB5C2B8f9e8a93df938690918c07BBFD4DDFEB5C2B"
Cc: Steven_Lin@notes.teradyne.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=07BBFD4DDFEB5C2B8f9e8a93df938690918c07BBFD4DDFEB5C2B
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable



My application needs a fast way to access a specific physical DDR memor=
y
region. The application runs on an MPC8548 PowerPC which has an MMU. I'=
ve
tried two approaches that are typical for Linux, mmap() and using a ker=
nel
module that implements read()/write() into this region and I'm finding =
that
performance is very slow for both. It's a couple orders of magnitude sl=
ower
than, for example, copying a large buffer from one place in the
application's virtual memory to another place in the application's virt=
ual
memory.

Steve Lin=

--0__=07BBFD4DDFEB5C2B8f9e8a93df938690918c07BBFD4DDFEB5C2B
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><font size=3D"2" face=3D"Courier New">My application needs a fast wa=
y to access a specific physical DDR memory region. The application runs=
 on an MPC8548 PowerPC which has an MMU. I've tried two approaches that=
 are typical for Linux, mmap() and using a kernel module that implement=
s read()/write() into this region and I'm finding that performance is v=
ery slow for both. It's a couple orders of magnitude slower than, for e=
xample, copying a large buffer from one place in the application's virt=
ual memory to another place in the application's virtual memory.</font>=
<br>
<br>
<font size=3D"2" face=3D"Courier New">Steve Lin</font></body></html>=

--0__=07BBFD4DDFEB5C2B8f9e8a93df938690918c07BBFD4DDFEB5C2B--
