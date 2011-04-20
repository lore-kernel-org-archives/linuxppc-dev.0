Return-Path: <andre.schwarz@matrix-vision.de>
Received: from mail2.matrix-vision.com (mail2.matrix-vision.com
	[85.214.244.251])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "template", Issuer "template" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 50F6FB6FED
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Apr 2011 05:28:51 +1000 (EST)
Received: from mail2.matrix-vision.com (localhost [127.0.0.1])
	by mail2.matrix-vision.com (Postfix) with ESMTP id 0EE983F663
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Apr 2011 21:21:01 +0200 (CEST)
Received: from polydeuces (g1.matrix-vision.com [217.7.222.190])
	by mail2.matrix-vision.com (Postfix) with ESMTPA id E07DD3F61D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Apr 2011 21:21:00 +0200 (CEST)
Received: from polydeuces (sao.intern.matrix-vision.de [192.168.5.121])
	by polydeuces (Postfix) with ESMTP id 7FFEC5F9D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Apr 2011 21:21:00 +0200 (CEST)
Received: from proteus.g1.matrix-vision.de (proteus.intern.matrix-vision.de
	[192.168.5.122]) by polydeuces (Postfix) with ESMTPA id 5AB495F9D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Apr 2011 21:21:00 +0200 (CEST)
Date: Wed, 20 Apr 2011 21:21:00 +0200 (CEST)
From: "Schwarz,Andre" <andre.schwarz@matrix-vision.de>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Message-ID: <211009162.1147.1303327260364.JavaMail.open-xchange@proteus>
Subject: tmpfs size restriction
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1146_153851450.1303327260351"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------=_Part_1146_153851450.1303327260351
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I'm facing an issue with tmpfs mounts on PowerPC (mpc83xx specifically).

After "mount -t tmpfs tmpfs /tmp -o size=3D16m" I can fill the machine's me=
m
(512MiB) until oom becomes active.

I can't see this on any other machine (x86/ARM) I have access to.
There's always a "no space left on device" message as soon as size specifie=
d is
reached ...

kernel versions available are v2.6.26.27 and v2.6.34.7 showing the same
behaviour.

I'd expect the kernel to limit available tmpfs size to 50% of physical memo=
ry
anyway.

Any ideas what might be wrong ?


Regards,
Andr=C3=A9
=0AMATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler=0ARegistergerich=
t: Amtsgericht Stuttgart, HRB 271090=0AGeschaeftsfuehrer: Gerhard Thullner, =
Werner Armingeon, Uwe Furtner=0A

------=_Part_1146_153851450.1303327260351
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
    <title></title>
  </head>

  <body>
    Hi,<br/>
    <br/>
    I&#39;m facing an issue with tmpfs mounts on PowerPC (mpc83xx specifically).<br/>
    <br/>
    After &quot;mount -t tmpfs tmpfs /tmp -o size=16m&quot; I can fill the machine&#39;s mem (512MiB) until oom becomes active.<br/>
    <br/>
    I can&#39;t see this on any other machine (x86/ARM) I have access to.<br/>
    There&#39;s always a &quot;no space left on device&quot; message as soon as size specified is reached ...<br/>
    <br/>
    kernel versions available are v2.6.26.27 and v2.6.34.7 showing the same behaviour.<br/>
    <br/>
    I&#39;d expect the kernel to limit available tmpfs size to 50% of physical memory anyway.<br/>
    <br/>
    Any ideas what might be wrong ?<br/>
    <br/>
    <br/>
    Regards,<br/>
    Andr&#233;
  
<br>

MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
<br>
</body>
</html>
------=_Part_1146_153851450.1303327260351--
