Return-Path: <weese.stanford@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.204])
	by ozlabs.org (Postfix) with ESMTP id 5B32F67B80
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Feb 2006 21:58:10 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 50so474453wri
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Feb 2006 02:58:09 -0800 (PST)
Message-ID: <251f20df0602250258w3e0009cdu464bacb9dcf7e7bc@mail.gmail.com>
Date: Sat, 25 Feb 2006 02:58:09 -0800
From: "Sewook Wee" <weese@stanford.edu>
Sender: weese.stanford@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: Data Cache Write Through
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_22745_30262751.1140865089695"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_22745_30262751.1140865089695
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

------=_Part_22745_30262751.1140865089695
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
<div>&nbsp;</div><br clear=3D"all"><br>-- <br>Sewook Wee<br>&nbsp;&nbsp;<a =
href=3D"mailto:weese@stanford.edu">weese@stanford.edu</a><br>&nbsp;&nbsp;Co=
mputer System Laboratory <br>&nbsp;&nbsp;Stanford University=20

------=_Part_22745_30262751.1140865089695--
