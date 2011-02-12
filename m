Return-Path: <dcb314@hotmail.com>
Received: from blu0-omc3-s4.blu0.hotmail.com (blu0-omc3-s4.blu0.hotmail.com
	[65.55.116.79]) by ozlabs.org (Postfix) with ESMTP id E59A9B70E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Feb 2011 21:13:49 +1100 (EST)
Message-ID: <BLU154-w1013E8541813DF8B7564CD9CEE0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_e86b3faa-e9d0-4427-b633-237642e46f22_"
From: David Binderman <dcb314@hotmail.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>
Subject: arch/powerpc/kernel/cacheinfo.c: Possible null pointer dereference
Date: Sat, 12 Feb 2011 10:08:36 +0000
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_e86b3faa-e9d0-4427-b633-237642e46f22_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello there=2C

I just tried out cppcheck-1.47 on the linux-2.6.38-rc4 source code.

It said

[arch/powerpc/kernel/cacheinfo.c:380]: (error) Possible null pointer derefe=
rence: cache - otherwise it is redundant to check if cache is null at line =
382

The source code is

    WARN_ONCE(cache && cache->level !=3D level=2C
          "cache level mismatch on lookup (got %d=2C expected %d)\n"=2C
          cache->level=2C level)=3B

    if (!cache)

I agree with cppcheck. Suggest code rework.

Regards

David Binderman

 		 	   		  =

--_e86b3faa-e9d0-4427-b633-237642e46f22_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style>
</head>
<body class=3D'hmmessage'>
Hello there=2C<br><br>I just tried out cppcheck-1.47 on the linux-2.6.38-rc=
4 source code.<br><br>It said<br><br>[arch/powerpc/kernel/cacheinfo.c:380]:=
 (error) Possible null pointer dereference: cache - otherwise it is redunda=
nt to check if cache is null at line 382<br><br>The source code is<br><br>&=
nbsp=3B&nbsp=3B&nbsp=3B WARN_ONCE(cache &amp=3B&amp=3B cache-&gt=3Blevel !=
=3D level=2C<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B "cache level mismatch on lookup (got %d=2C expected %d)\n"=2C=
<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B cache-&gt=3Blevel=2C level)=3B<br><br>&nbsp=3B&nbsp=3B&nbsp=3B if (!cac=
he)<br><br>I agree with cppcheck. Suggest code rework.<br><br>Regards<br><b=
r>David Binderman<br><br> 		 	   		  </body>
</html>=

--_e86b3faa-e9d0-4427-b633-237642e46f22_--
