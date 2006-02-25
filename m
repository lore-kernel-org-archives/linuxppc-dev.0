Return-Path: <weese.stanford@gmail.com>
Received: from pproxy.gmail.com (pproxy.gmail.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id 79F9E67B5F
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Feb 2006 21:44:36 +1100 (EST)
Received: by pproxy.gmail.com with SMTP id o67so526240pye
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Feb 2006 02:44:35 -0800 (PST)
Message-ID: <251f20df0602250244l1cf9acd1x11b44cb9643b3de1@mail.gmail.com>
Date: Sat, 25 Feb 2006 02:44:35 -0800
From: "Sewook Wee" <weese@stanford.edu>
Sender: weese.stanford@gmail.com
To: linuxppc-dev@ozlabs.org
Subject: Data Cache Write-through
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_22717_24854404.1140864275593"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_22717_24854404.1140864275593
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello all,

I am Sewook Wee at Stanford University.
For the research purpose, I am hacking the linux kernel (version 2.4.30) fo=
r
The PPC405 in Virtex II Pro Xilinx FPGA.
What I want to do is make Data Cache policy to be write-through, not
write-back.
I changed the DCWR Value in the arch/ppc/mm/44x_mmu.c, but seems it does no=
t
work.

I hope some of you have decent idea to make it happen.

Thanks.

--
Sewook Wee
  weese@stanford.edu
  Computer System Laboratory
  Stanford University

------=_Part_22717_24854404.1140864275593
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hello all, </div>
<div>&nbsp;</div>
<div>I am Sewook Wee at Stanford University.</div>
<div>For the research purpose, I am hacking the linux kernel (version 2.4.3=
0) for The PPC405 in Virtex II Pro Xilinx FPGA. </div>
<div>What I want to do is make Data Cache policy to be write-through, not w=
rite-back.</div>
<div>I changed the DCWR Value in the arch/ppc/mm/44x_mmu.c, but seems it do=
es not work. </div>
<div>&nbsp;</div>
<div>I hope some of you have decent idea to make it happen.</div>
<div>&nbsp;</div>
<div>Thanks.</div>
<div>&nbsp;</div>
<div>-- <br>Sewook Wee<br>&nbsp;&nbsp;<a href=3D"mailto:weese@stanford.edu"=
>weese@stanford.edu</a><br>&nbsp;&nbsp;Computer System Laboratory <br>&nbsp=
;&nbsp;Stanford University </div>

------=_Part_22717_24854404.1140864275593--
