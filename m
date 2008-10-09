Return-Path: <ducquannguyen@yahoo.com>
Received: from web51406.mail.re2.yahoo.com (web51406.mail.re2.yahoo.com
	[206.190.38.185]) by ozlabs.org (Postfix) with SMTP id A85F8DDF1D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Oct 2008 11:03:08 +1100 (EST)
Date: Thu, 9 Oct 2008 16:56:26 -0700 (PDT)
From: Nguyen Duc Quan <ducquannguyen@yahoo.com>
Subject: RE: API access I2C
To: Duy-Ky Nguyen <duykynguyen@hotmail.com>, linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1896715470-1223596586=:78574"
Message-ID: <243068.78574.qm@web51406.mail.re2.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1896715470-1223596586=:78574
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I think I2C-tools is what you need as sample code to access I2C in Linux. H=
ere is the link=0Ahttp://dl.lm-sensors.org/i2c-tools/releases/i2c-tools-3.0=
.1.tar.bz2=0AThere are a lot of tools to access, set/get/dump register, rea=
d/write the I2C eeprom...=0ABut please use them with care, especially when =
you try to read/write the device at address 0x50 ( it's is bootstrap eeprom=
). =0AYou might not boot up your board after playing with this device :-)=
=0AQuan Nguyen=0A=0A=0A=0A----- Th=C6=B0 g=E1=BB=91c ----=0AT=E1=BB=AB: Duy=
-Ky Nguyen <duykynguyen@hotmail.com>=0A=C4=90=E1=BA=BFn: linuxppc-embedded@=
ozlabs.org=0AG=E1=BB=ADi ng=C3=A0y: Th=E1=BB=A9 S=C3=A1u, 10 th=C3=A1ng 10,=
 2008 6:11:22=0ACh=E1=BB=A7 =C4=91=E1=BB=81: API access I2C=0A=0AHello,=0A=
=0AI have an eva board MPC8313E-RDB with 3 I2C device at address 48, 50, 68=
.=0AI'm able to read data from those 3 devices=0A=0AI follow linux/Document=
ation/i2c/dev-interface to create a C code to access =0Athose 3 devices in =
Linux env, but all are failed !!!=0A=0AI really appreciate your help where =
to find  info or sample code running in =0ALinyux to access I2C devices=0A=
=0AThanks so much,=0A=0ADuy-Ky=0A=0A----- Original Message ----- =0AFrom: <=
linuxppc-embedded-request@ozlabs.org>=0ATo: <linuxppc-embedded@ozlabs.org>=
=0ASent: Thursday, October 09, 2008 2:05 PM=0ASubject: Linuxppc-embedded Di=
gest, Vol 50, Issue 14=0A=0A=0A> Send Linuxppc-embedded mailing list submis=
sions to=0A> linuxppc-embedded@ozlabs.org=0A>=0A> To subscribe or unsubscri=
be via the World Wide Web, visit=0A> https://ozlabs.org/mailman/listinfo/li=
nuxppc-embedded=0A> or, via email, send a message with subject or body 'hel=
p' to=0A> linuxppc-embedded-request@ozlabs.org=0A>=0A> You can reach the pe=
rson managing the list at=0A> linuxppc-embedded-owner@ozlabs.org=0A>=0A> Wh=
en replying, please edit your Subject line so it is more specific=0A> than =
"Re: Contents of Linuxppc-embedded digest..."=0A>=0A>=0A> Today's Topics:=
=0A>=0A>   1. Re: performance: memcpy vs. __copy_tofrom_user (Leon Woestenb=
erg)=0A>   2. Re: performance: memcpy vs. __copy_tofrom_user (Matt Sealey)=
=0A>   3. Toolchain for ppc-440 without FPU (Ademir Zanetti Junior)=0A>   4=
. Re: FS_ENET ERROR(s) 0x12 at second NFS RPC port lookup=0A>      (100005/=
1) (Remi Lefevre)=0A>   5. MTD map drivers (FSL UPM NAND) (Alemao)=0A>   6.=
 RE: Toolchain for ppc-440 without FPU (Ayman El-Khashab)=0A>=0A>=0A> -----=
-----------------------------------------------------------------=0A>=0A> M=
essage: 1=0A> Date: Thu, 9 Oct 2008 14:04:53 +0200=0A> From: "Leon Woestenb=
erg" <leon.woestenberg@gmail.com>=0A> Subject: Re: performance: memcpy vs. =
__copy_tofrom_user=0A> To: "Dominik Bozek" <domino@mikroswiat.pl>=0A> Cc: l=
inuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,=0A> linuxppc-emb=
edded@ozlabs.org=0A> Message-ID:=0A> <c384c5ea0810090504x570cb6aai6d136a150=
e74ac05@mail.gmail.com>=0A> Content-Type: text/plain; charset=3DISO-8859-1=
=0A>=0A> Hello all,=0A>=0A> On Thu, Oct 9, 2008 at 1:41 PM, Dominik Bozek <=
domino@mikroswiat.pl> =0A> wrote:=0A>> Paul Mackerras wrote:=0A>>> Dominik =
Bozek writes:=0A>>>> Actually I made couple of other tests on that mpc8313.=
 Most of them are=0A>>>> to ugly to publish them, but... My problem is that=
 I have to boost the=0A>>>> gigabit interface on the mpc8313. I made simple=
 substitution and=0A>>>=0A>>> Very interesting.  Can you work out where mem=
cpy is being called on=0A>>> the network data?  I wouldn't have expected th=
at.=0A>>>=0A>=0A> Also see this recent thread David Jander on August 25th, =
"Efficient=0A> memcpy()/memmove() for G2/G3 cores..."=0A> on linuxppc-dev@o=
zlabs.org.=0A>=0A> http://ozlabs.org/pipermail/linuxppc-dev/2008-September/=
062449.html=0A>=0A> BTW, I am interested in this work as well, I'm currentl=
y working with=0A> a 8313 and 8315 design, both are e300 cores.=0A>=0A> My =
current goal is PCIe though, but I need fast GbE performance as well.=0A>=
=0A> Also, did you test Freescale's 2.6.24.3 patches that tune the gianfar=
=0A> interfaces for higher performance?=0A>=0A> Regards,=0A> -- =0A> Leon=
=0A>=0A>=0A> ------------------------------=0A>=0A> Message: 2=0A> Date: Th=
u, 09 Oct 2008 10:37:55 -0500=0A> From: Matt Sealey <matt@genesi-usa.com>=
=0A> Subject: Re: performance: memcpy vs. __copy_tofrom_user=0A> To: Paul M=
ackerras <paulus@samba.org>=0A> Cc: linuxppc-dev@ozlabs.org, Dominik Bozek =
<domino@mikroswiat.pl>,=0A> linuxppc-embedded@ozlabs.org=0A> Message-ID: <4=
8EE2553.30903@genesi-usa.com>=0A> Content-Type: text/plain; charset=3DUTF-8=
; format=3Dflowed=0A>=0A> Paul Mackerras wrote:=0A>> Dominik Bozek writes:=
=0A>>=0A>>> Actually I made couple of other tests on that mpc8313. Most of =
them are=0A>>> to ugly to publish them, but... My problem is that I have to=
 boost the=0A>>> gigabit interface on the mpc8313. I made simple substituti=
on and=0A>>> __copy_tofrom_user was used instead of memcpy. I know, it's wr=
ong, but I=0A>>> speedup that way the network interface for about 10%.=0A>>=
=0A>> Very interesting.  Can you work out where memcpy is being called on=
=0A>> the network data?  I wouldn't have expected that.=0A>=0A> It probably=
 is somewhere.. through some weird and wonderful code path that=0A> needs s=
ome serious digging to find. At least in 2.4 memcpy was used and=0A> optimi=
zing it (see Freescale's libmotovec benchmarks) did produce a =0A> sizable=
=0A> performance improvement. That, and offloading TCP checksumming to Alti=
Vec=0A> helped a lot.=0A>=0A> No help at all on an 8313 but, relevant anywa=
y.=0A>=0A> Since then zero copy networking and other fancy things like the =
DMA=0A> engine API (for intel ioat at least but also there is fsl dma suppo=
rt)=0A> there's less to actually optimize now so you're less likely to see =
the=0A> same benefits. All these got into mainline because it's essential t=
o=0A> have this kind of architecture to get reasonable speeds out of >gigab=
it=0A> network links.=0A>=0A>> There is actually no strong reason not to us=
e __copy_tofrom_user as=0A>> memcpy, in fact, as long as we are sure that s=
ource and destination=0A>> are both cacheable.=0A>=0A> I do think there is =
probably a good benefit in doing things like zeroing=0A> pages in AltiVec a=
nd copying entire pages with AltiVec (for instance=0A> when copy-on-write h=
appens in an application) - NetBSD and QNX implement=0A> at least this beca=
use it's faster than using the cache management and=0A> works fine on uncac=
heable pages too (also since you're always aligned to=0A> a page, zeroing 4=
kb aligned to a 4kb boundary - or whatever your page=0A> size happens to be=
, the number of errors that can occur are absolutely=0A> tiny and performan=
ce can go through the roof).=0A>=0A> Ahem, but nobody here wants AltiVec in=
 the kernel do they?=0A>=0A> -- =0A> Matt Sealey <matt@genesi-usa.com>=0A> =
Genesi, Manager, Developer Relations=0A>=0A>=0A> --------------------------=
----=0A>=0A> Message: 3=0A> Date: Thu, 9 Oct 2008 16:08:18 -0300=0A> From: =
"Ademir Zanetti Junior" <ademirzanetti@gmail.com>=0A> Subject: Toolchain fo=
r ppc-440 without FPU=0A> To: linuxppc-embedded@ozlabs.org=0A> Message-ID:=
=0A> <2204d6480810091208u1776e81fx6597719734751edb@mail.gmail.com>=0A> Cont=
ent-Type: text/plain; charset=3D"utf-8"=0A>=0A> Hello all,=0A>=0A> I am try=
ing to create a toolchain by hand and I am facing some problems =0A> when=
=0A> I try to configure the glibc 2.7 for a powerpc. When I try to configur=
e =0A> the=0A> glibc to install the headers I get the following error:=0A>=
=0A> configure --prefix=3D/usr --host=3Dpowerpc-440-linux-gnu=0A> --with-he=
aders=3D${SYSROOT}/usr/include --disable-shared --without-cvs=0A> --with-bi=
nutils=3D/home/azanetti/ml507/powerpc/bin/=0A>=0A> checking build system ty=
pe... i686-pc-linux-gnu=0A> checking host system type... i686-pc-linux-gnu=
=0A> configure: running configure fragment for add-on nptl=0A> checking sys=
dep dirs... sysdeps/i386/elf=0A> nptl/sysdeps/unix/sysv/linux/i386/i686 npt=
l/sysdeps/unix/sysv/linux/i386=0A> sysdeps/unix/sysv/linux/i386 nptl/sysdep=
s/unix/sysv/linux=0A> nptl/sysdeps/pthread sysdeps/pthread sysdeps/unix/sys=
v/linux sysdeps/gnu=0A> sysdeps/unix/common sysdeps/unix/mman sysdeps/unix/=
inet=0A> sysdeps/unix/sysv/i386 nptl/sysdeps/unix/sysv sysdeps/unix/sysv=0A=
> sysdeps/unix/i386 nptl/sysdeps/unix sysdeps/unix sysdeps/posix=0A> sysdep=
s/i386/i686/fpu nptl/sysdeps/i386/i686 sysdeps/i386/i686=0A> sysdeps/i386/i=
486 nptl/sysdeps/i386/i486 sysdeps/i386/fpu =0A> nptl/sysdeps/i386=0A> sysd=
eps/i386 sysdeps/wordsize-32 sysdeps/ieee754/ldbl-96=0A> sysdeps/ieee754/db=
l-64 sysdeps/ieee754/flt-32 sysdeps/ieee754=0A> sysdeps/generic/elf sysdeps=
/generic=0A> checking for a BSD-compatible install... /usr/bin/install -c=
=0A> checking whether ln -s works... yes=0A> checking for gcc... gcc=0A> ch=
ecking for suffix of object files... o=0A> checking whether we are using th=
e GNU C compiler... yes=0A> checking whether gcc accepts -g... yes=0A> chec=
king for gcc option to accept ISO C89... none needed=0A> checking how to ru=
n the C preprocessor... gcc -E=0A> checking for g++... g++=0A>=0A> .=0A> .=
=0A> .=0A> checking for long double... yes=0A> checking size of long double=
... 12=0A> running configure fragment for sysdeps/powerpc/powerpc32/elf=0A>=
 checking for powerpc32 TLS support... no=0A> running configure fragment fo=
r sysdeps/unix/sysv/linux/powerpc=0A> checking whether gcc -B/home/azanetti=
/ml507/powerpc/bin/ -g -O2=0A> -mlong-double-128 uses IBM extended format..=
. no=0A> checking whether gcc -B/home/azanetti/ml507/powerpc/bin/ -g -O2 su=
pports=0A> -mabi=3Dibmlongdouble... no=0A> configure: error: this configura=
tion requires -mlong-double-128 IBM =0A> extended=0A> format support=0A>=0A=
>=0A> I already have the binutils 2.18 compiled on my PATH. I know that it =
is=0A> easier to use a script like crosstool to compile it but I do want to=
=0A> understand what is happening behind the scenes.=0A>=0A> Regards.=0A>=
=0A> Ademir=0A> -------------- next part --------------=0A> An HTML attachm=
ent was scrubbed...=0A> URL: =0A> <http://ozlabs.org/pipermail/linuxppc-emb=
edded/attachments/20081009/a3dd71d6/attachment-0001.htm>=0A>=0A> ----------=
--------------------=0A>=0A> Message: 4=0A> Date: Thu, 9 Oct 2008 21:46:42 =
+0200=0A> From: "Remi Lefevre" <rlefevre@gmail.com>=0A> Subject: Re: FS_ENE=
T ERROR(s) 0x12 at second NFS RPC port lookup=0A> (100005/1)=0A> To: "Scott=
 Wood" <scottwood@freescale.com>=0A> Cc: linuxppc-embedded@ozlabs.org=0A> M=
essage-ID:=0A> <4e0b9cb00810091246i2f200dbn9f8dc9877800e629@mail.gmail.com>=
=0A> Content-Type: text/plain; charset=3DISO-8859-1=0A>=0A> Ok, I'm sorry, =
I have incorrectly set the 60x pipeline depth to 0=0A> instead of 1 in BCR =
register.=0A> It works fine now. The side effect is interesting to know...=
=0A>=0A> regards,=0A> r?mi=0A>=0A>=0A> ------------------------------=0A>=
=0A> Message: 5=0A> Date: Thu, 9 Oct 2008 18:04:25 -0300=0A> From: Alemao <=
xcarandiru@gmail.com>=0A> Subject: MTD map drivers (FSL UPM NAND)=0A> To: l=
inuxppc-embedded@ozlabs.org=0A> Message-ID:=0A> <d970ff420810091404j49492e8=
0xcd9250d0ffdcd592@mail.gmail.com>=0A> Content-Type: text/plain; charset=3D=
ISO-8859-1=0A>=0A> Hi all,=0A>=0A> Im trying to use a physmap driver for NO=
R and NAND flash devices.=0A>=0A> With NOR, everything ok. It uses CFI driv=
er.=0A>=0A> The problem is with NAND, cause it is connected at Freescale=0A=
> LocalBus UPM, and at a first look, the UPM driver is loading after the=0A=
> physmap (lines 14-15 in kernel output)=0A>=0A> Here some outputs from the=
 board:=0A>=0A> Bootloader (U-Boot 1.2.0):=0A>=0A> CPU:   e300c1, MPC8360E,=
 Rev: 21 at 499.999 MHz, CSB:  333 MHz=0A> Board: MPC8360KTX=0A> I2C:   rea=
dy=0A> DDR RAM: 128 MB=0A> FLASH: 16 MB=0A> NAND:  64 MiB=0A> In:    serial=
=0A> Out:   serial=0A> Err:   serial=0A>=0A>=0A> Kernel (linux-2.6.17):=0A>=
=0A> 1               physmap nor flash device: 1000000 at ff000000=0A> 2   =
            NOR flash: Found 1 x16 devices at 0x0 in 16-bit bank=0A> 3     =
           Amd/Fujitsu Extended Query Table at 0x0040=0A> 4                =
number of CFI chips: 1=0A> 5               Using physmap partition definiti=
on=0A> 6               Creating 6 MTD partitions on "NOR flash":=0A> 7     =
          0x00000000-0x00040000 : "u-boot"=0A> 8               0x00040000-0=
x00060000 : "env."=0A> 9               0x00060000-0x00080000 : "sys"=0A> 10=
              0x00080000-0x000c0000 : "logs"=0A> 11              0x000c0000=
-0x00860000 : "admin"=0A> 12              0x00860000-0x01000000 : "users"=
=0A> 13=0A> 14              physmap nand flash device: 4000000 at 60000000=
=0A> 15              UPM: User-Programmable Machine NAND driver=0A>=0A>=0A>=
 Device Tree Source:=0A>=0A> localbus@e0005000 {=0A>  compatible =3D "fsl,b=
oard-localbus";=0A>  #address-cells =3D <2>;=0A>  #size-cells =3D <1>;=0A> =
 reg =3D <e0005000 d8>;    // BRx, ORx, etc=0A>=0A>  ranges =3D <0 0 ff0000=
00 1000000     // nor flash,  16 MB=0A>                    1 0 60000000 400=
0000>;   // nand flash, 64 MB=0A>=0A>  flash@0,0 {=0A>      compatible =3D =
"atmel,29LV256", "cfi-flash";=0A>      reg =3D <0 0 1000000>;=0A>      bank=
-width =3D <2>;=0A>      device-width =3D <1>;=0A>  };=0A>=0A>  nand@1,0 {=
=0A>      compatible =3D "stmicro,NAND512W3A", "fsl,upm-nand";=0A>      reg=
 =3D <1 0 4000000>;   //reg =3D <1 0 1>;=0A>      width =3D <1>;=0A>      u=
pm =3D "A";=0A>      upm-addr-offset =3D <16>;=0A>      upm-cmd-offset =3D =
<8>;=0A>      gpios =3D <4 18>;=0A>      gpio-parent =3D <&qe_pio>;=0A>    =
  wait-pattern;=0A>      wait-write;=0A>  };=0A> };=0A>=0A> The CFI driver =
is at linux/drivers/mtd/chips=0A> The UPM driver is at linux/drivers/mtd/na=
nd=0A>=0A> So, how can I load the UPM driver before physmap?=0A>=0A> Thanks=
 in advance,=0A>=0A> --=0A> Alemao=0A>=0A>=0A> ----------------------------=
--=0A>=0A> Message: 6=0A> Date: Thu, 9 Oct 2008 16:05:47 -0500=0A> From: "A=
yman El-Khashab" <AymanE@tanisys.com>=0A> Subject: RE: Toolchain for ppc-44=
0 without FPU=0A> To: "Ademir Zanetti Junior" <ademirzanetti@gmail.com>,=0A=
> <linuxppc-embedded@ozlabs.org>=0A> Message-ID:=0A> <16691A8B34B5D9458EA3A=
1C37A11555A0137F80B@tanisys-ex2.Tanisys.Local>=0A> Content-Type: text/plain=
; charset=3D"us-ascii"=0A>=0A> I was compiling for the 440FP under cygwin, =
I believe that I had to use=0A> --enable-long-long when I configured gcc in=
 order to build glibc.=0A>=0A> ________________________________=0A>=0A> Fro=
m: linuxppc-embedded-bounces+aymane=3Dtanisys.com@ozlabs.org=0A> [mailto:li=
nuxppc-embedded-bounces+aymane=3Dtanisys.com@ozlabs.org] On=0A> Behalf Of A=
demir Zanetti Junior=0A> Sent: Thursday, October 09, 2008 2:08 PM=0A> To: l=
inuxppc-embedded@ozlabs.org=0A> Subject: Toolchain for ppc-440 without FPU=
=0A>=0A>=0A> Hello all,=0A>=0A> I am trying to create a toolchain by hand a=
nd I am facing some problems=0A> when I try to configure the glibc 2.7 for =
a powerpc. When I try to=0A> configure the glibc to install the headers I g=
et the following error:=0A>=0A> configure --prefix=3D/usr --host=3Dpowerpc-=
440-linux-gnu=0A> --with-headers=3D${SYSROOT}/usr/include --disable-shared =
--without-cvs=0A> --with-binutils=3D/home/azanetti/ml507/powerpc/bin/=0A>=
=0A> checking build system type... i686-pc-linux-gnu=0A> checking host syst=
em type... i686-pc-linux-gnu=0A> configure: running configure fragment for =
add-on nptl=0A> checking sysdep dirs... sysdeps/i386/elf=0A> nptl/sysdeps/u=
nix/sysv/linux/i386/i686 nptl/sysdeps/unix/sysv/linux/i386=0A> sysdeps/unix=
/sysv/linux/i386 nptl/sysdeps/unix/sysv/linux=0A> nptl/sysdeps/pthread sysd=
eps/pthread sysdeps/unix/sysv/linux sysdeps/gnu=0A> sysdeps/unix/common sys=
deps/unix/mman sysdeps/unix/inet=0A> sysdeps/unix/sysv/i386 nptl/sysdeps/un=
ix/sysv sysdeps/unix/sysv=0A> sysdeps/unix/i386 nptl/sysdeps/unix sysdeps/u=
nix sysdeps/posix=0A> sysdeps/i386/i686/fpu nptl/sysdeps/i386/i686 sysdeps/=
i386/i686=0A> sysdeps/i386/i486 nptl/sysdeps/i386/i486 sysdeps/i386/fpu=0A>=
 nptl/sysdeps/i386 sysdeps/i386 sysdeps/wordsize-32=0A> sysdeps/ieee754/ldb=
l-96 sysdeps/ieee754/dbl-64 sysdeps/ieee754/flt-32=0A> sysdeps/ieee754 sysd=
eps/generic/elf sysdeps/generic=0A> checking for a BSD-compatible install..=
. /usr/bin/install -c=0A> checking whether ln -s works... yes=0A> checking =
for gcc... gcc=0A> checking for suffix of object files... o=0A> checking wh=
ether we are using the GNU C compiler... yes=0A> checking whether gcc accep=
ts -g... yes=0A> checking for gcc option to accept ISO C89... none needed=
=0A> checking how to run the C preprocessor... gcc -E=0A> checking for g++.=
.. g++=0A>=0A> .=0A> .=0A> .=0A> checking for long double... yes=0A> checki=
ng size of long double... 12=0A> running configure fragment for sysdeps/pow=
erpc/powerpc32/elf=0A> checking for powerpc32 TLS support... no=0A> running=
 configure fragment for sysdeps/unix/sysv/linux/powerpc=0A> checking whethe=
r gcc -B/home/azanetti/ml507/powerpc/bin/ -g -O2=0A> -mlong-double-128 uses=
 IBM extended format... no=0A> checking whether gcc -B/home/azanetti/ml507/=
powerpc/bin/ -g -O2 supports=0A> -mabi=3Dibmlongdouble... no=0A> configure:=
 error: this configuration requires -mlong-double-128 IBM=0A> extended form=
at support=0A>=0A>=0A> I already have the binutils 2.18 compiled on my PATH=
. I know that it is=0A> easier to use a script like crosstool to compile it=
 but I do want to=0A> understand what is happening behind the scenes.=0A>=
=0A> Regards.=0A>=0A> Ademir=0A>=0A> -------------- next part -------------=
-=0A> An HTML attachment was scrubbed...=0A> URL: =0A> <http://ozlabs.org/p=
ipermail/linuxppc-embedded/attachments/20081009/c91ac7a9/attachment.htm>=0A=
>=0A> ------------------------------=0A>=0A> ______________________________=
_________________=0A> Linuxppc-embedded mailing list=0A> Linuxppc-embedded@=
ozlabs.org=0A> https://ozlabs.org/mailman/listinfo/linuxppc-embedded=0A>=0A=
> End of Linuxppc-embedded Digest, Vol 50, Issue 14=0A> *******************=
******************************=0A> =0A=0A__________________________________=
_____________=0ALinuxppc-embedded mailing list=0ALinuxppc-embedded@ozlabs.o=
rg=0Ahttps://ozlabs.org/mailman/listinfo/linuxppc-embedded=0A=0A=0A=0A     =
 B=E1=BA=A1n c=C3=B3 =C3=BD ki=E1=BA=BFn v=E1=BB=81 M=E1=BB=B9 T=C3=A2m?=0A=
H=C3=A3y c=C3=B9ng chia s=E1=BA=BB v=E1=BB=9Bi m=E1=BB=8Di ng=C6=B0=E1=BB=
=9Di t=E1=BA=A1i Yahoo! Vi=E1=BB=87t Nam Music=0Ahttp://vn.music.yahoo.com/=
artist/100000056?
--0-1896715470-1223596586=:78574
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div>I think I2C-tools is what you need as sample code to a=
ccess I2C in Linux. Here is the link<br>http://dl.lm-sensors.org/i2c-tools/=
releases/i2c-tools-3.0.1.tar.bz2<br>There are a lot of tools to access, set=
/get/dump register, read/write the I2C eeprom...<br>But please use them wit=
h care, especially when you try to read/write the device at address 0x50 ( =
it's is bootstrap eeprom). <br>You might not boot up your board after playi=
ng with this device :-)<br>Quan Nguyen<br></div><div style=3D"font-family: =
times new roman,new york,times,serif; font-size: 12pt;"><br><div style=3D"f=
ont-family: arial,helvetica,sans-serif; font-size: 10pt;">----- Th=C6=B0 g=
=E1=BB=91c ----<br>T=E1=BB=AB: Duy-Ky Nguyen &lt;duykynguyen@hotmail.com&gt=
;<br>=C4=90=E1=BA=BFn: linuxppc-embedded@ozlabs.org<br>G=E1=BB=ADi ng=C3=A0=
y: Th=E1=BB=A9 S=C3=A1u, 10 th=C3=A1ng 10, 2008
 6:11:22<br>Ch=E1=BB=A7 =C4=91=E1=BB=81: API access I2C<br><br>Hello,<br><b=
r>I have an eva board MPC8313E-RDB with 3 I2C device at address 48, 50, 68.=
<br>I'm able to read data from those 3 devices<br><br>I follow linux/Docume=
ntation/i2c/dev-interface to create a C code to access <br>those 3 devices =
in Linux env, but all are failed !!!<br><br>I really appreciate your help w=
here to find&nbsp; info or sample code running in <br>Linyux to access I2C =
devices<br><br>Thanks so much,<br><br>Duy-Ky<br><br>----- Original Message =
----- <br>From: &lt;<a ymailto=3D"mailto:linuxppc-embedded-request@ozlabs.o=
rg" href=3D"mailto:linuxppc-embedded-request@ozlabs.org">linuxppc-embedded-=
request@ozlabs.org</a>&gt;<br>To: &lt;<a ymailto=3D"mailto:linuxppc-embedde=
d@ozlabs.org" href=3D"mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedde=
d@ozlabs.org</a>&gt;<br>Sent: Thursday, October 09, 2008 2:05 PM<br>Subject=
: Linuxppc-embedded Digest, Vol 50, Issue 14<br><br><br>&gt; Send Linuxppc-=
embedded mailing
 list submissions to<br>&gt; <a ymailto=3D"mailto:linuxppc-embedded@ozlabs.=
org" href=3D"mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.=
org</a><br>&gt;<br>&gt; To subscribe or unsubscribe via the World Wide Web,=
 visit<br>&gt; <a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embe=
dded" target=3D"_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedd=
ed</a><br>&gt; or, via email, send a message with subject or body 'help' to=
<br>&gt; <a ymailto=3D"mailto:linuxppc-embedded-request@ozlabs.org" href=3D=
"mailto:linuxppc-embedded-request@ozlabs.org">linuxppc-embedded-request@ozl=
abs.org</a><br>&gt;<br>&gt; You can reach the person managing the list at<b=
r>&gt; <a ymailto=3D"mailto:linuxppc-embedded-owner@ozlabs.org" href=3D"mai=
lto:linuxppc-embedded-owner@ozlabs.org">linuxppc-embedded-owner@ozlabs.org<=
/a><br>&gt;<br>&gt; When replying, please edit your Subject line so it is m=
ore specific<br>&gt; than "Re: Contents of Linuxppc-embedded
 digest..."<br>&gt;<br>&gt;<br>&gt; Today's Topics:<br>&gt;<br>&gt;&nbsp;  =
1. Re: performance: memcpy vs. __copy_tofrom_user (Leon Woestenberg)<br>&gt=
;&nbsp;  2. Re: performance: memcpy vs. __copy_tofrom_user (Matt Sealey)<br=
>&gt;&nbsp;  3. Toolchain for ppc-440 without FPU (Ademir Zanetti Junior)<b=
r>&gt;&nbsp;  4. Re: FS_ENET ERROR(s) 0x12 at second NFS RPC port lookup<br=
>&gt;&nbsp; &nbsp; &nbsp; (100005/1) (Remi Lefevre)<br>&gt;&nbsp;  5. MTD m=
ap drivers (FSL UPM NAND) (Alemao)<br>&gt;&nbsp;  6. RE: Toolchain for ppc-=
440 without FPU (Ayman El-Khashab)<br>&gt;<br>&gt;<br>&gt; ----------------=
------------------------------------------------------<br>&gt;<br>&gt; Mess=
age: 1<br>&gt; Date: Thu, 9 Oct 2008 14:04:53 +0200<br>&gt; From: "Leon Woe=
stenberg" &lt;<a ymailto=3D"mailto:leon.woestenberg@gmail.com" href=3D"mail=
to:leon.woestenberg@gmail.com">leon.woestenberg@gmail.com</a>&gt;<br>&gt; S=
ubject: Re: performance: memcpy vs. __copy_tofrom_user<br>&gt; To:
 "Dominik Bozek" &lt;<a ymailto=3D"mailto:domino@mikroswiat.pl" href=3D"mai=
lto:domino@mikroswiat.pl">domino@mikroswiat.pl</a>&gt;<br>&gt; Cc: <a ymail=
to=3D"mailto:linuxppc-dev@ozlabs.org" href=3D"mailto:linuxppc-dev@ozlabs.or=
g">linuxppc-dev@ozlabs.org</a>, Paul Mackerras &lt;<a ymailto=3D"mailto:pau=
lus@samba.org" href=3D"mailto:paulus@samba.org">paulus@samba.org</a>&gt;,<b=
r>&gt; <a ymailto=3D"mailto:linuxppc-embedded@ozlabs.org" href=3D"mailto:li=
nuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org</a><br>&gt; Messag=
e-ID:<br>&gt; &lt;<a ymailto=3D"mailto:c384c5ea0810090504x570cb6aai6d136a15=
0e74ac05@mail.gmail.com" href=3D"mailto:c384c5ea0810090504x570cb6aai6d136a1=
50e74ac05@mail.gmail.com">c384c5ea0810090504x570cb6aai6d136a150e74ac05@mail=
.gmail.com</a>&gt;<br>&gt; Content-Type: text/plain; charset=3DISO-8859-1<b=
r>&gt;<br>&gt; Hello all,<br>&gt;<br>&gt; On Thu, Oct 9, 2008 at 1:41 PM, D=
ominik Bozek &lt;<a ymailto=3D"mailto:domino@mikroswiat.pl"
 href=3D"mailto:domino@mikroswiat.pl">domino@mikroswiat.pl</a>&gt; <br>&gt;=
 wrote:<br>&gt;&gt; Paul Mackerras wrote:<br>&gt;&gt;&gt; Dominik Bozek wri=
tes:<br>&gt;&gt;&gt;&gt; Actually I made couple of other tests on that mpc8=
313. Most of them are<br>&gt;&gt;&gt;&gt; to ugly to publish them, but... M=
y problem is that I have to boost the<br>&gt;&gt;&gt;&gt; gigabit interface=
 on the mpc8313. I made simple substitution and<br>&gt;&gt;&gt;<br>&gt;&gt;=
&gt; Very interesting.&nbsp; Can you work out where memcpy is being called =
on<br>&gt;&gt;&gt; the network data?&nbsp; I wouldn't have expected that.<b=
r>&gt;&gt;&gt;<br>&gt;<br>&gt; Also see this recent thread David Jander on =
August 25th, "Efficient<br>&gt; memcpy()/memmove() for G2/G3 cores..."<br>&=
gt; on <a ymailto=3D"mailto:linuxppc-dev@ozlabs.org" href=3D"mailto:linuxpp=
c-dev@ozlabs.org">linuxppc-dev@ozlabs.org</a>.<br>&gt;<br>&gt; <a href=3D"h=
ttp://ozlabs.org/pipermail/linuxppc-dev/2008-September/062449.html"
 target=3D"_blank">http://ozlabs.org/pipermail/linuxppc-dev/2008-September/=
062449.html</a><br>&gt;<br>&gt; BTW, I am interested in this work as well, =
I'm currently working with<br>&gt; a 8313 and 8315 design, both are e300 co=
res.<br>&gt;<br>&gt; My current goal is PCIe though, but I need fast GbE pe=
rformance as well.<br>&gt;<br>&gt; Also, did you test Freescale's 2.6.24.3 =
patches that tune the gianfar<br>&gt; interfaces for higher performance?<br=
>&gt;<br>&gt; Regards,<br>&gt; -- <br>&gt; Leon<br>&gt;<br>&gt;<br>&gt; ---=
---------------------------<br>&gt;<br>&gt; Message: 2<br>&gt; Date: Thu, 0=
9 Oct 2008 10:37:55 -0500<br>&gt; From: Matt Sealey &lt;<a ymailto=3D"mailt=
o:matt@genesi-usa.com" href=3D"mailto:matt@genesi-usa.com">matt@genesi-usa.=
com</a>&gt;<br>&gt; Subject: Re: performance: memcpy vs. __copy_tofrom_user=
<br>&gt; To: Paul Mackerras &lt;<a ymailto=3D"mailto:paulus@samba.org" href=
=3D"mailto:paulus@samba.org">paulus@samba.org</a>&gt;<br>&gt; Cc: <a
 ymailto=3D"mailto:linuxppc-dev@ozlabs.org" href=3D"mailto:linuxppc-dev@ozl=
abs.org">linuxppc-dev@ozlabs.org</a>, Dominik Bozek &lt;<a ymailto=3D"mailt=
o:domino@mikroswiat.pl" href=3D"mailto:domino@mikroswiat.pl">domino@mikrosw=
iat.pl</a>&gt;,<br>&gt; <a ymailto=3D"mailto:linuxppc-embedded@ozlabs.org" =
href=3D"mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org</=
a><br>&gt; Message-ID: &lt;<a ymailto=3D"mailto:48EE2553.30903@genesi-usa.c=
om" href=3D"mailto:48EE2553.30903@genesi-usa.com">48EE2553.30903@genesi-usa=
.com</a>&gt;<br>&gt; Content-Type: text/plain; charset=3DUTF-8; format=3Dfl=
owed<br>&gt;<br>&gt; Paul Mackerras wrote:<br>&gt;&gt; Dominik Bozek writes=
:<br>&gt;&gt;<br>&gt;&gt;&gt; Actually I made couple of other tests on that=
 mpc8313. Most of them are<br>&gt;&gt;&gt; to ugly to publish them, but... =
My problem is that I have to boost the<br>&gt;&gt;&gt; gigabit interface on=
 the mpc8313. I made simple substitution and<br>&gt;&gt;&gt; __copy_tofrom_=
user was used
 instead of memcpy. I know, it's wrong, but I<br>&gt;&gt;&gt; speedup that =
way the network interface for about 10%.<br>&gt;&gt;<br>&gt;&gt; Very inter=
esting.&nbsp; Can you work out where memcpy is being called on<br>&gt;&gt; =
the network data?&nbsp; I wouldn't have expected that.<br>&gt;<br>&gt; It p=
robably is somewhere.. through some weird and wonderful code path that<br>&=
gt; needs some serious digging to find. At least in 2.4 memcpy was used and=
<br>&gt; optimizing it (see Freescale's libmotovec benchmarks) did produce =
a <br>&gt; sizable<br>&gt; performance improvement. That, and offloading TC=
P checksumming to AltiVec<br>&gt; helped a lot.<br>&gt;<br>&gt; No help at =
all on an 8313 but, relevant anyway.<br>&gt;<br>&gt; Since then zero copy n=
etworking and other fancy things like the DMA<br>&gt; engine API (for intel=
 ioat at least but also there is fsl dma support)<br>&gt; there's less to a=
ctually optimize now so you're less likely to see the<br>&gt; same
 benefits. All these got into mainline because it's essential to<br>&gt; ha=
ve this kind of architecture to get reasonable speeds out of &gt;gigabit<br=
>&gt; network links.<br>&gt;<br>&gt;&gt; There is actually no strong reason=
 not to use __copy_tofrom_user as<br>&gt;&gt; memcpy, in fact, as long as w=
e are sure that source and destination<br>&gt;&gt; are both cacheable.<br>&=
gt;<br>&gt; I do think there is probably a good benefit in doing things lik=
e zeroing<br>&gt; pages in AltiVec and copying entire pages with AltiVec (f=
or instance<br>&gt; when copy-on-write happens in an application) - NetBSD =
and QNX implement<br>&gt; at least this because it's faster than using the =
cache management and<br>&gt; works fine on uncacheable pages too (also sinc=
e you're always aligned to<br>&gt; a page, zeroing 4kb aligned to a 4kb bou=
ndary - or whatever your page<br>&gt; size happens to be, the number of err=
ors that can occur are absolutely<br>&gt; tiny and performance can
 go through the roof).<br>&gt;<br>&gt; Ahem, but nobody here wants AltiVec =
in the kernel do they?<br>&gt;<br>&gt; -- <br>&gt; Matt Sealey &lt;<a ymail=
to=3D"mailto:matt@genesi-usa.com" href=3D"mailto:matt@genesi-usa.com">matt@=
genesi-usa.com</a>&gt;<br>&gt; Genesi, Manager, Developer Relations<br>&gt;=
<br>&gt;<br>&gt; ------------------------------<br>&gt;<br>&gt; Message: 3<=
br>&gt; Date: Thu, 9 Oct 2008 16:08:18 -0300<br>&gt; From: "Ademir Zanetti =
Junior" &lt;<a ymailto=3D"mailto:ademirzanetti@gmail.com" href=3D"mailto:ad=
emirzanetti@gmail.com">ademirzanetti@gmail.com</a>&gt;<br>&gt; Subject: Too=
lchain for ppc-440 without FPU<br>&gt; To: <a ymailto=3D"mailto:linuxppc-em=
bedded@ozlabs.org" href=3D"mailto:linuxppc-embedded@ozlabs.org">linuxppc-em=
bedded@ozlabs.org</a><br>&gt; Message-ID:<br>&gt; &lt;<a ymailto=3D"mailto:=
2204d6480810091208u1776e81fx6597719734751edb@mail.gmail.com"
 href=3D"mailto:2204d6480810091208u1776e81fx6597719734751edb@mail.gmail.com=
">2204d6480810091208u1776e81fx6597719734751edb@mail.gmail.com</a>&gt;<br>&g=
t; Content-Type: text/plain; charset=3D"utf-8"<br>&gt;<br>&gt; Hello all,<b=
r>&gt;<br>&gt; I am trying to create a toolchain by hand and I am facing so=
me problems <br>&gt; when<br>&gt; I try to configure the glibc 2.7 for a po=
werpc. When I try to configure <br>&gt; the<br>&gt; glibc to install the he=
aders I get the following error:<br>&gt;<br>&gt; configure --prefix=3D/usr =
--host=3Dpowerpc-440-linux-gnu<br>&gt; --with-headers=3D${SYSROOT}/usr/incl=
ude --disable-shared --without-cvs<br>&gt; --with-binutils=3D/home/azanetti=
/ml507/powerpc/bin/<br>&gt;<br>&gt; checking build system type... i686-pc-l=
inux-gnu<br>&gt; checking host system type... i686-pc-linux-gnu<br>&gt; con=
figure: running configure fragment for add-on nptl<br>&gt; checking sysdep =
dirs... sysdeps/i386/elf<br>&gt; nptl/sysdeps/unix/sysv/linux/i386/i686
 nptl/sysdeps/unix/sysv/linux/i386<br>&gt; sysdeps/unix/sysv/linux/i386 npt=
l/sysdeps/unix/sysv/linux<br>&gt; nptl/sysdeps/pthread sysdeps/pthread sysd=
eps/unix/sysv/linux sysdeps/gnu<br>&gt; sysdeps/unix/common sysdeps/unix/mm=
an sysdeps/unix/inet<br>&gt; sysdeps/unix/sysv/i386 nptl/sysdeps/unix/sysv =
sysdeps/unix/sysv<br>&gt; sysdeps/unix/i386 nptl/sysdeps/unix sysdeps/unix =
sysdeps/posix<br>&gt; sysdeps/i386/i686/fpu nptl/sysdeps/i386/i686 sysdeps/=
i386/i686<br>&gt; sysdeps/i386/i486 nptl/sysdeps/i386/i486 sysdeps/i386/fpu=
 <br>&gt; nptl/sysdeps/i386<br>&gt; sysdeps/i386 sysdeps/wordsize-32 sysdep=
s/ieee754/ldbl-96<br>&gt; sysdeps/ieee754/dbl-64 sysdeps/ieee754/flt-32 sys=
deps/ieee754<br>&gt; sysdeps/generic/elf sysdeps/generic<br>&gt; checking f=
or a BSD-compatible install... /usr/bin/install -c<br>&gt; checking whether=
 ln -s works... yes<br>&gt; checking for gcc... gcc<br>&gt; checking for su=
ffix of object files... o<br>&gt; checking whether we are using the
 GNU C compiler... yes<br>&gt; checking whether gcc accepts -g... yes<br>&g=
t; checking for gcc option to accept ISO C89... none needed<br>&gt; checkin=
g how to run the C preprocessor... gcc -E<br>&gt; checking for g++... g++<b=
r>&gt;<br>&gt; .<br>&gt; .<br>&gt; .<br>&gt; checking for long double... ye=
s<br>&gt; checking size of long double... 12<br>&gt; running configure frag=
ment for sysdeps/powerpc/powerpc32/elf<br>&gt; checking for powerpc32 TLS s=
upport... no<br>&gt; running configure fragment for sysdeps/unix/sysv/linux=
/powerpc<br>&gt; checking whether gcc -B/home/azanetti/ml507/powerpc/bin/ -=
g -O2<br>&gt; -mlong-double-128 uses IBM extended format... no<br>&gt; chec=
king whether gcc -B/home/azanetti/ml507/powerpc/bin/ -g -O2 supports<br>&gt=
; -mabi=3Dibmlongdouble... no<br>&gt; configure: error: this configuration =
requires -mlong-double-128 IBM <br>&gt; extended<br>&gt; format support<br>=
&gt;<br>&gt;<br>&gt; I already have the binutils 2.18 compiled on my
 PATH. I know that it is<br>&gt; easier to use a script like crosstool to c=
ompile it but I do want to<br>&gt; understand what is happening behind the =
scenes.<br>&gt;<br>&gt; Regards.<br>&gt;<br>&gt; Ademir<br>&gt; -----------=
--- next part --------------<br>&gt; An HTML attachment was scrubbed...<br>=
&gt; URL: <br>&gt; &lt;<a href=3D"http://ozlabs.org/pipermail/linuxppc-embe=
dded/attachments/20081009/a3dd71d6/attachment-0001.htm" target=3D"_blank">h=
ttp://ozlabs.org/pipermail/linuxppc-embedded/attachments/20081009/a3dd71d6/=
attachment-0001.htm</a>&gt;<br>&gt;<br>&gt; ------------------------------<=
br>&gt;<br>&gt; Message: 4<br>&gt; Date: Thu, 9 Oct 2008 21:46:42 +0200<br>=
&gt; From: "Remi Lefevre" &lt;<a ymailto=3D"mailto:rlefevre@gmail.com" href=
=3D"mailto:rlefevre@gmail.com">rlefevre@gmail.com</a>&gt;<br>&gt; Subject: =
Re: FS_ENET ERROR(s) 0x12 at second NFS RPC port lookup<br>&gt; (100005/1)<=
br>&gt; To: "Scott Wood" &lt;<a ymailto=3D"mailto:scottwood@freescale.com"
 href=3D"mailto:scottwood@freescale.com">scottwood@freescale.com</a>&gt;<br=
>&gt; Cc: <a ymailto=3D"mailto:linuxppc-embedded@ozlabs.org" href=3D"mailto=
:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org</a><br>&gt; Mes=
sage-ID:<br>&gt; &lt;<a ymailto=3D"mailto:4e0b9cb00810091246i2f200dbn9f8dc9=
877800e629@mail.gmail.com" href=3D"mailto:4e0b9cb00810091246i2f200dbn9f8dc9=
877800e629@mail.gmail.com">4e0b9cb00810091246i2f200dbn9f8dc9877800e629@mail=
.gmail.com</a>&gt;<br>&gt; Content-Type: text/plain; charset=3DISO-8859-1<b=
r>&gt;<br>&gt; Ok, I'm sorry, I have incorrectly set the 60x pipeline depth=
 to 0<br>&gt; instead of 1 in BCR register.<br>&gt; It works fine now. The =
side effect is interesting to know...<br>&gt;<br>&gt; regards,<br>&gt; r?mi=
<br>&gt;<br>&gt;<br>&gt; ------------------------------<br>&gt;<br>&gt; Mes=
sage: 5<br>&gt; Date: Thu, 9 Oct 2008 18:04:25 -0300<br>&gt; From: Alemao &=
lt;<a ymailto=3D"mailto:xcarandiru@gmail.com"
 href=3D"mailto:xcarandiru@gmail.com">xcarandiru@gmail.com</a>&gt;<br>&gt; =
Subject: MTD map drivers (FSL UPM NAND)<br>&gt; To: <a ymailto=3D"mailto:li=
nuxppc-embedded@ozlabs.org" href=3D"mailto:linuxppc-embedded@ozlabs.org">li=
nuxppc-embedded@ozlabs.org</a><br>&gt; Message-ID:<br>&gt; &lt;<a ymailto=
=3D"mailto:d970ff420810091404j49492e80xcd9250d0ffdcd592@mail.gmail.com" hre=
f=3D"mailto:d970ff420810091404j49492e80xcd9250d0ffdcd592@mail.gmail.com">d9=
70ff420810091404j49492e80xcd9250d0ffdcd592@mail.gmail.com</a>&gt;<br>&gt; C=
ontent-Type: text/plain; charset=3DISO-8859-1<br>&gt;<br>&gt; Hi all,<br>&g=
t;<br>&gt; Im trying to use a physmap driver for NOR and NAND flash devices=
.<br>&gt;<br>&gt; With NOR, everything ok. It uses CFI driver.<br>&gt;<br>&=
gt; The problem is with NAND, cause it is connected at Freescale<br>&gt; Lo=
calBus UPM, and at a first look, the UPM driver is loading after the<br>&gt=
; physmap (lines 14-15 in kernel output)<br>&gt;<br>&gt; Here some outputs =
from
 the board:<br>&gt;<br>&gt; Bootloader (U-Boot 1.2.0):<br>&gt;<br>&gt; CPU:=
&nbsp;  e300c1, MPC8360E, Rev: 21 at 499.999 MHz, CSB:&nbsp; 333 MHz<br>&gt=
; Board: MPC8360KTX<br>&gt; I2C:&nbsp;  ready<br>&gt; DDR RAM: 128 MB<br>&g=
t; FLASH: 16 MB<br>&gt; NAND:&nbsp; 64 MiB<br>&gt; In:&nbsp; &nbsp; serial<=
br>&gt; Out:&nbsp;  serial<br>&gt; Err:&nbsp;  serial<br>&gt;<br>&gt;<br>&g=
t; Kernel (linux-2.6.17):<br>&gt;<br>&gt; 1&nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp;  physmap nor flash device: 1000000 at ff000000<br>&gt; 2&n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  NOR flash: Found 1 x16 devi=
ces at 0x0 in 16-bit bank<br>&gt; 3&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; Amd/Fujitsu Extended Query Table at 0x0040<br>&gt; 4&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; number of CFI chips: 1<br>=
&gt; 5&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  Using physmap parti=
tion definition<br>&gt; 6&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
 &nbsp;  Creating 6 MTD partitions on "NOR flash":<br>&gt; 7&nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  0x00000000-0x00040000 : "u-boot"<br>&gt;=
 8&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  0x00040000-0x00060000 :=
 "env."<br>&gt; 9&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  0x000600=
00-0x00080000 : "sys"<br>&gt; 10&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; 0x00080000-0x000c0000 : "logs"<br>&gt; 11&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; 0x000c0000-0x00860000 : "admin"<br>&gt; 12&nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x00860000-0x01000000 : "users"<br>&gt=
; 13<br>&gt; 14&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; physmap nan=
d flash device: 4000000 at 60000000<br>&gt; 15&nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; UPM: User-Programmable Machine NAND driver<br>&gt;<br>&=
gt;<br>&gt; Device Tree Source:<br>&gt;<br>&gt; localbus@e0005000 {<br>&gt;=
&nbsp; compatible =3D "fsl,board-localbus";<br>&gt;&nbsp;
 #address-cells =3D &lt;2&gt;;<br>&gt;&nbsp; #size-cells =3D &lt;1&gt;;<br>=
&gt;&nbsp; reg =3D &lt;e0005000 d8&gt;;&nbsp; &nbsp; // BRx, ORx, etc<br>&g=
t;<br>&gt;&nbsp; ranges =3D &lt;0 0 ff000000 1000000&nbsp; &nbsp;  // nor f=
lash,&nbsp; 16 MB<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; 1 0 60000000 4000000&gt;;&nbsp;  // nand flash, 64 MB<b=
r>&gt;<br>&gt;&nbsp; flash@0,0 {<br>&gt;&nbsp; &nbsp; &nbsp; compatible =3D=
 "atmel,29LV256", "cfi-flash";<br>&gt;&nbsp; &nbsp; &nbsp; reg =3D &lt;0 0 =
1000000&gt;;<br>&gt;&nbsp; &nbsp; &nbsp; bank-width =3D &lt;2&gt;;<br>&gt;&=
nbsp; &nbsp; &nbsp; device-width =3D &lt;1&gt;;<br>&gt;&nbsp; };<br>&gt;<br=
>&gt;&nbsp; nand@1,0 {<br>&gt;&nbsp; &nbsp; &nbsp; compatible =3D "stmicro,=
NAND512W3A", "fsl,upm-nand";<br>&gt;&nbsp; &nbsp; &nbsp; reg =3D &lt;1 0 40=
00000&gt;;&nbsp;  //reg =3D &lt;1 0 1&gt;;<br>&gt;&nbsp; &nbsp; &nbsp; widt=
h =3D &lt;1&gt;;<br>&gt;&nbsp; &nbsp; &nbsp; upm =3D "A";<br>&gt;&nbsp; &nb=
sp; &nbsp;
 upm-addr-offset =3D &lt;16&gt;;<br>&gt;&nbsp; &nbsp; &nbsp; upm-cmd-offset=
 =3D &lt;8&gt;;<br>&gt;&nbsp; &nbsp; &nbsp; gpios =3D &lt;4 18&gt;;<br>&gt;=
&nbsp; &nbsp; &nbsp; gpio-parent =3D &lt;&amp;qe_pio&gt;;<br>&gt;&nbsp; &nb=
sp; &nbsp; wait-pattern;<br>&gt;&nbsp; &nbsp; &nbsp; wait-write;<br>&gt;&nb=
sp; };<br>&gt; };<br>&gt;<br>&gt; The CFI driver is at linux/drivers/mtd/ch=
ips<br>&gt; The UPM driver is at linux/drivers/mtd/nand<br>&gt;<br>&gt; So,=
 how can I load the UPM driver before physmap?<br>&gt;<br>&gt; Thanks in ad=
vance,<br>&gt;<br>&gt; --<br>&gt; Alemao<br>&gt;<br>&gt;<br>&gt; ----------=
--------------------<br>&gt;<br>&gt; Message: 6<br>&gt; Date: Thu, 9 Oct 20=
08 16:05:47 -0500<br>&gt; From: "Ayman El-Khashab" &lt;<a ymailto=3D"mailto=
:AymanE@tanisys.com" href=3D"mailto:AymanE@tanisys.com">AymanE@tanisys.com<=
/a>&gt;<br>&gt; Subject: RE: Toolchain for ppc-440 without FPU<br>&gt; To: =
"Ademir Zanetti Junior" &lt;<a ymailto=3D"mailto:ademirzanetti@gmail.com"
 href=3D"mailto:ademirzanetti@gmail.com">ademirzanetti@gmail.com</a>&gt;,<b=
r>&gt; &lt;<a ymailto=3D"mailto:linuxppc-embedded@ozlabs.org" href=3D"mailt=
o:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org</a>&gt;<br>&gt=
; Message-ID:<br>&gt; &lt;<a ymailto=3D"mailto:16691A8B34B5D9458EA3A1C37A11=
555A0137F80B@tanisys-ex2.Tanisys.Local" href=3D"mailto:16691A8B34B5D9458EA3=
A1C37A11555A0137F80B@tanisys-ex2.Tanisys.Local">16691A8B34B5D9458EA3A1C37A1=
1555A0137F80B@tanisys-ex2.Tanisys.Local</a>&gt;<br>&gt; Content-Type: text/=
plain; charset=3D"us-ascii"<br>&gt;<br>&gt; I was compiling for the 440FP u=
nder cygwin, I believe that I had to use<br>&gt; --enable-long-long when I =
configured gcc in order to build glibc.<br>&gt;<br>&gt; ___________________=
_____________<br>&gt;<br>&gt; From: linuxppc-embedded-bounces+aymane=3D<a y=
mailto=3D"mailto:tanisys.com@ozlabs.org" href=3D"mailto:tanisys.com@ozlabs.=
org">tanisys.com@ozlabs.org</a><br>&gt; [mailto:linuxppc-embedded-bounces+a=
ymane=3D<a
 ymailto=3D"mailto:tanisys.com@ozlabs.org" href=3D"mailto:tanisys.com@ozlab=
s.org">tanisys.com@ozlabs.org</a>] On<br>&gt; Behalf Of Ademir Zanetti Juni=
or<br>&gt; Sent: Thursday, October 09, 2008 2:08 PM<br>&gt; To: <a ymailto=
=3D"mailto:linuxppc-embedded@ozlabs.org" href=3D"mailto:linuxppc-embedded@o=
zlabs.org">linuxppc-embedded@ozlabs.org</a><br>&gt; Subject: Toolchain for =
ppc-440 without FPU<br>&gt;<br>&gt;<br>&gt; Hello all,<br>&gt;<br>&gt; I am=
 trying to create a toolchain by hand and I am facing some problems<br>&gt;=
 when I try to configure the glibc 2.7 for a powerpc. When I try to<br>&gt;=
 configure the glibc to install the headers I get the following error:<br>&=
gt;<br>&gt; configure --prefix=3D/usr --host=3Dpowerpc-440-linux-gnu<br>&gt=
; --with-headers=3D${SYSROOT}/usr/include --disable-shared --without-cvs<br=
>&gt; --with-binutils=3D/home/azanetti/ml507/powerpc/bin/<br>&gt;<br>&gt; c=
hecking build system type... i686-pc-linux-gnu<br>&gt; checking host system=
 type...
 i686-pc-linux-gnu<br>&gt; configure: running configure fragment for add-on=
 nptl<br>&gt; checking sysdep dirs... sysdeps/i386/elf<br>&gt; nptl/sysdeps=
/unix/sysv/linux/i386/i686 nptl/sysdeps/unix/sysv/linux/i386<br>&gt; sysdep=
s/unix/sysv/linux/i386 nptl/sysdeps/unix/sysv/linux<br>&gt; nptl/sysdeps/pt=
hread sysdeps/pthread sysdeps/unix/sysv/linux sysdeps/gnu<br>&gt; sysdeps/u=
nix/common sysdeps/unix/mman sysdeps/unix/inet<br>&gt; sysdeps/unix/sysv/i3=
86 nptl/sysdeps/unix/sysv sysdeps/unix/sysv<br>&gt; sysdeps/unix/i386 nptl/=
sysdeps/unix sysdeps/unix sysdeps/posix<br>&gt; sysdeps/i386/i686/fpu nptl/=
sysdeps/i386/i686 sysdeps/i386/i686<br>&gt; sysdeps/i386/i486 nptl/sysdeps/=
i386/i486 sysdeps/i386/fpu<br>&gt; nptl/sysdeps/i386 sysdeps/i386 sysdeps/w=
ordsize-32<br>&gt; sysdeps/ieee754/ldbl-96 sysdeps/ieee754/dbl-64 sysdeps/i=
eee754/flt-32<br>&gt; sysdeps/ieee754 sysdeps/generic/elf sysdeps/generic<b=
r>&gt; checking for a BSD-compatible install... /usr/bin/install
 -c<br>&gt; checking whether ln -s works... yes<br>&gt; checking for gcc...=
 gcc<br>&gt; checking for suffix of object files... o<br>&gt; checking whet=
her we are using the GNU C compiler... yes<br>&gt; checking whether gcc acc=
epts -g... yes<br>&gt; checking for gcc option to accept ISO C89... none ne=
eded<br>&gt; checking how to run the C preprocessor... gcc -E<br>&gt; check=
ing for g++... g++<br>&gt;<br>&gt; .<br>&gt; .<br>&gt; .<br>&gt; checking f=
or long double... yes<br>&gt; checking size of long double... 12<br>&gt; ru=
nning configure fragment for sysdeps/powerpc/powerpc32/elf<br>&gt; checking=
 for powerpc32 TLS support... no<br>&gt; running configure fragment for sys=
deps/unix/sysv/linux/powerpc<br>&gt; checking whether gcc -B/home/azanetti/=
ml507/powerpc/bin/ -g -O2<br>&gt; -mlong-double-128 uses IBM extended forma=
t... no<br>&gt; checking whether gcc -B/home/azanetti/ml507/powerpc/bin/ -g=
 -O2 supports<br>&gt; -mabi=3Dibmlongdouble... no<br>&gt; configure:
 error: this configuration requires -mlong-double-128 IBM<br>&gt; extended =
format support<br>&gt;<br>&gt;<br>&gt; I already have the binutils 2.18 com=
piled on my PATH. I know that it is<br>&gt; easier to use a script like cro=
sstool to compile it but I do want to<br>&gt; understand what is happening =
behind the scenes.<br>&gt;<br>&gt; Regards.<br>&gt;<br>&gt; Ademir<br>&gt;<=
br>&gt; -------------- next part --------------<br>&gt; An HTML attachment =
was scrubbed...<br>&gt; URL: <br>&gt; &lt;<a href=3D"http://ozlabs.org/pipe=
rmail/linuxppc-embedded/attachments/20081009/c91ac7a9/attachment.htm" targe=
t=3D"_blank">http://ozlabs.org/pipermail/linuxppc-embedded/attachments/2008=
1009/c91ac7a9/attachment.htm</a>&gt;<br>&gt;<br>&gt; ----------------------=
--------<br>&gt;<br>&gt; _______________________________________________<br=
>&gt; Linuxppc-embedded mailing list<br>&gt; <a ymailto=3D"mailto:Linuxppc-=
embedded@ozlabs.org"
 href=3D"mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org<=
/a><br>&gt; <a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedde=
d" target=3D"_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded<=
/a><br>&gt;<br>&gt; End of Linuxppc-embedded Digest, Vol 50, Issue 14<br>&g=
t; *************************************************<br>&gt; <br><br>______=
_________________________________________<br>Linuxppc-embedded mailing list=
<br><a ymailto=3D"mailto:Linuxppc-embedded@ozlabs.org" href=3D"mailto:Linux=
ppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br><a href=3D"htt=
ps://ozlabs.org/mailman/listinfo/linuxppc-embedded" target=3D"_blank">https=
://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></div></div></div><=
br>=0A      <hr size=3D"1"><FONT face=3DArial size=3D-1>N=C6=B0=E1=BB=9Bc n=
=C3=A0o th=C6=B0=E1=BB=9Dng cho nhi=E1=BB=81u h=E1=BB=8Dc b=E1=BB=95ng du h=
=E1=BB=8Dc? Kh=C3=A1m ph=C3=A1 t=E1=BA=A1i <a href=3D"http://sg.rd.yahoo.co=
m/mail/vn/footer/def/*http://vn.answers.yahoo.com">Yahoo! H=E1=BB=8Fi & =C4=
=90=C3=A1p</a></font></body></html>
--0-1896715470-1223596586=:78574--
