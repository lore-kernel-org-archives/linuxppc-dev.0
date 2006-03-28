Return-Path: <jcrigby@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.195])
	by ozlabs.org (Postfix) with ESMTP id F1F5867A2E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Mar 2006 12:01:30 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id s17so1090176wxc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Mar 2006 17:01:28 -0800 (PST)
Message-ID: <4b73d43f0603271701q24910d9rf4e61e5136c2b727@mail.gmail.com>
Date: Mon, 27 Mar 2006 18:01:28 -0700
From: "John Rigby" <jcrigby@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel for MPC Lite 5200 will not compile
In-Reply-To: <20060328000703.GA95672@server.idefix.loc>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5931_27956094.1143507688522"
References: <20060328000703.GA95672@server.idefix.loc>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_5931_27956094.1143507688522
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

try make lite5200_defconfig instead of copying it to .config
or make oldconfig after copying ti to .config

On 3/27/06, Matthias Fechner <idefix@fechner.net> wrote:
>
> Hi,
>
> I installed today ELDK 4.0 for the LITE5200 board (icecube).
> ./install -d /usr/local/eldk ppc_6xx
>
> After compiling u-boot and playing a little bit with it, i tried to
> compile the kernel 2.6.
>
> For this I used the git repository.
> I copied the file arch/ppc/configs/lite5200_defconfig to .config, and
> tried the following one:
> make ARCH=3Dppc CROSS_COMPILE=3Dppc_6xx- uImage
>
> But i got a failure with the following error message:
>   CC      arch/ppc/syslib/bestcomm/bestcomm.o
> arch/ppc/syslib/bestcomm/bestcomm.c: In function 'mpc52xx_sdma_probe':
> arch/ppc/syslib/bestcomm/bestcomm.c:269: warning: implicit declaration of
> function 'to_platform_device'
> arch/ppc/syslib/bestcomm/bestcomm.c:269: warning: initialization makes
> pointer from integer without a cast
> arch/ppc/syslib/bestcomm/bestcomm.c:278: warning: implicit declaration of
> function 'platform_get_resource'
> arch/ppc/syslib/bestcomm/bestcomm.c:278: warning: assignment makes pointe=
r
> from integer without a cast
> arch/ppc/syslib/bestcomm/bestcomm.c:279: warning: assignment makes pointe=
r
> from integer without a cast
> arch/ppc/syslib/bestcomm/bestcomm.c: At top level:
> arch/ppc/syslib/bestcomm/bestcomm.c:367: error: 'platform_bus_type'
> undeclared here (not in a function)
> make[2]: *** [arch/ppc/syslib/bestcomm/bestcomm.o] Fehler 1
> make[1]: *** [arch/ppc/syslib/bestcomm] Fehler 2
> make: *** [arch/ppc/syslib] Fehler 2
>
> What is wrong here, I think i did an error on any step...
>
> Thx for help!
>
> Best regards,
> Matthias
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_5931_27956094.1143507688522
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

try make lite5200_defconfig instead of copying it to .config<br>or make old=
config after copying ti to .config<br><br><div><span class=3D"gmail_quote">=
On 3/27/06, <b class=3D"gmail_sendername">Matthias Fechner</b> &lt;<a href=
=3D"mailto:idefix@fechner.net">
idefix@fechner.net</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">Hi,<br><br>I installed today ELDK 4.0 for the LITE52=
00 board (icecube).
<br>./install -d /usr/local/eldk ppc_6xx<br><br>After compiling u-boot and =
playing a little bit with it, i tried to<br>compile the kernel 2.6.<br><br>=
For this I used the git repository.<br>I copied the file arch/ppc/configs/l=
ite5200_defconfig to .config, and
<br>tried the following one:<br>make ARCH=3Dppc CROSS_COMPILE=3Dppc_6xx- uI=
mage<br><br>But i got a failure with the following error message:<br>&nbsp;=
&nbsp;CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/ppc/syslib/bestcomm/bestco=
mm.o arch/ppc/syslib/bestcomm/bestcomm.c: In function 'mpc52xx_sdma_probe':
<br>arch/ppc/syslib/bestcomm/bestcomm.c:269: warning: implicit declaration =
of function 'to_platform_device'<br>arch/ppc/syslib/bestcomm/bestcomm.c:269=
: warning: initialization makes pointer from integer without a cast<br>
arch/ppc/syslib/bestcomm/bestcomm.c:278: warning: implicit declaration of f=
unction 'platform_get_resource'<br>arch/ppc/syslib/bestcomm/bestcomm.c:278:=
 warning: assignment makes pointer from integer without a cast<br>arch/ppc/=
syslib/bestcomm/bestcomm.c:279: warning: assignment makes pointer from inte=
ger without a cast
<br>arch/ppc/syslib/bestcomm/bestcomm.c: At top level:<br>arch/ppc/syslib/b=
estcomm/bestcomm.c:367: error: 'platform_bus_type' undeclared here (not in =
a function)<br>make[2]: *** [arch/ppc/syslib/bestcomm/bestcomm.o] Fehler 1
<br>make[1]: *** [arch/ppc/syslib/bestcomm] Fehler 2<br>make: *** [arch/ppc=
/syslib] Fehler 2<br><br>What is wrong here, I think i did an error on any =
step...<br><br>Thx for help!<br><br>Best regards,<br>Matthias<br>__________=
_____________________________________
<br>Linuxppc-embedded mailing list<br><a href=3D"mailto:Linuxppc-embedded@o=
zlabs.org">Linuxppc-embedded@ozlabs.org</a><br><a href=3D"https://ozlabs.or=
g/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/l=
inuxppc-embedded
</a><br></blockquote></div><br>

------=_Part_5931_27956094.1143507688522--
