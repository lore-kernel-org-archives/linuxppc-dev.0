Return-Path: <ashish.bijlani@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.207])
	by ozlabs.org (Postfix) with ESMTP id 5F598685D0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Oct 2005 23:50:33 +1000 (EST)
Received: by xproxy.gmail.com with SMTP id t6so663914wxc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Oct 2005 06:50:32 -0700 (PDT)
Message-ID: <ec55b17e0510270617k368b4555gf3f37e07cee3b4e6@mail.gmail.com>
Date: Thu, 27 Oct 2005 18:47:29 +0530
From: Ashish Bijlani <ashish.bijlani@gmail.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_22574_21278703.1130419049883"
Subject: Board based on MPC7447 and MV64462
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_22574_21278703.1130419049883
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I've added platform support for a board based on MPC7447A and MV64462
Marvell Discovery III system controller. I modified code for Katana to make
it work for this board. The ethernet and serial are working fine but I don'=
t
see anything in "lspci" output. Also I don't see timer in "cat
/proc/interrupts". Does anybody have any idea on this? Thanks in advance.

Thanks,
Ashish

------=_Part_22574_21278703.1130419049883
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
I've added platform support for a board based on MPC7447A and MV64462
Marvell Discovery III system controller. I modified code for Katana to
make it work for this board. The ethernet and serial are working fine
but I don't see anything in &quot;lspci&quot; output. Also I don't see time=
r in
&quot;cat /proc/interrupts&quot;. Does anybody have any idea on this? Thank=
s in
advance.<br>
<br>
Thanks,<br>
Ashish<br>

------=_Part_22574_21278703.1130419049883--
