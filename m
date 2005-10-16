Return-Path: <som_kadam1@rediffmail.com>
Received: from rediffmail.com (unknown [202.54.124.216])
	by ozlabs.org (Postfix) with SMTP id C7EA06856A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Oct 2005 23:00:25 +1000 (EST)
Date: 16 Oct 2005 12:53:38 -0000
Message-ID: <20051016125338.12386.qmail@webmail50.rediffmail.com>
MIME-Version: 1.0
From: "somshekar chandrashekar kadam" <som_kadam1@rediffmail.com>
To: linuxppc-embedded@ozlabs.org
Content-type: multipart/alternative;
	boundary="Next_1129467218---0-202.54.124.216-12384"
Subject: denx 3.1.1 eldk ramdisk_image 
Reply-To: somshekar chandrashekar kadam <som_kadam1@rediffmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 This is a multipart mime message


--Next_1129467218---0-202.54.124.216-12384
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=0AHi ,=0A=0A  thanks Wlofgang Denk for the answer we can use ramdisk image=
 used for other kernel version , =0Anow i am using ELDK 3.1.1 , and also us=
ing the ramdisk image provided by the ELDK ramdisk_image.gz , =0Aand in ker=
nel i have configured for intial ramdisk support with size 4096 and for ext=
2 file system , =0Ait gives the message =0A=0AVFS kernel panic unable to mo=
unt root fs 01:00 =0A=0Ai tried both options =0Afirst one making a multi im=
age =0Ausing mkimage clubbing it into one image FI64_fresh , with vmlinux.g=
z and ramdisk_image.gz =0A=0A./mkimage -A ppc -O linux -T multi -C gzip -a =
0 -e 0 -n FI64_fresh -d vmlinux.gz:ramdisk_image.gz FI64_fresh=0A =A0=0Ai d=
ownload FI64_fresh at 0x500000 using tftpboot =0A=0Ause bootm 0x500000 to b=
oot the kernel i get the above message .=0A=0Asecond option =0A=0Aat 0x5000=
00 in ram i download uImage of the linux-2.4.25 .=0Aat 0x600000 i download =
ramdisk_image.gz =0A=0Aand use the command =0Abootm 0x500000 0x600000 =0A i=
 get the same message as above =0A=0Ai do intial check using imi command it=
 says images are fine after veryfing checksum =0A=0Ais it i am missing some=
thoing else please let me know or is there any other way to check this =0A=
=0A=0AThanks In Advance =0ANeelu =0A
--Next_1129467218---0-202.54.124.216-12384
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0A<BR>=0AHi ,<BR>=0A<BR>=0A&nbsp; thanks Wlofgang Denk for the answer w=
e can use ramdisk image used for other kernel version , <BR>=0Anow i am usi=
ng ELDK 3.1.1 , and also using the ramdisk image provided by the ELDK ramdi=
sk_image.gz , <BR>=0Aand in kernel i have configured for intial ramdisk sup=
port with size 4096 and for ext2 file system , <BR>=0Ait gives the message =
<BR>=0A<BR>=0AVFS kernel panic unable to mount root fs 01:00 <BR>=0A<BR>=0A=
i tried both options <BR>=0Afirst one making a multi image <BR>=0Ausing mki=
mage clubbing it into one image FI64_fresh , with vmlinux.gz and ramdisk_im=
age.gz <BR>=0A<BR>=0A./mkimage -A ppc -O linux -T multi -C gzip -a 0 -e 0 -=
n FI64_fresh -d vmlinux.gz:ramdisk_image.gz FI64_fresh<BR>=0A&nbsp; <BR>=0A=
i download FI64_fresh at 0x500000 using tftpboot <BR>=0A<BR>=0Ause bootm 0x=
500000 to boot the kernel i get the above message .<BR>=0A<BR>=0Asecond opt=
ion <BR>=0A<BR>=0Aat 0x500000 in ram i download uImage of the linux-2.4.25 =
.<BR>=0Aat 0x600000 i download ramdisk_image.gz <BR>=0A<BR>=0Aand use the c=
ommand <BR>=0Abootm 0x500000 0x600000 <BR>=0A i get the same message as abo=
ve <BR>=0A<BR>=0Ai do intial check using imi command it says images are fin=
e after veryfing checksum <BR>=0A<BR>=0Ais it i am missing somethoing else =
please let me know or is there any other way to check this <BR>=0A<BR>=0A<B=
R>=0AThanks In Advance <BR>=0ANeelu <BR>=0A=0A</P>=0A<br><br>=0A<a href=3D"=
http://adworks.rediff.com/cgi-bin/AdWorks/sigclick.cgi/www.rediff.com/signa=
ture-home.htm/1507191490@Middle5?PARTNER=3D3"><IMG SRC=3D"http://adworks.re=
diff.com/cgi-bin/AdWorks/sigimpress.cgi/www.rediff.com/signature-home.htm/1=
963059423@Middle5?OAS_query=3Dnull&PARTNER=3D3" BORDER=3D0 VSPACE=3D0 HSPAC=
E=3D0></a>=0A
--Next_1129467218---0-202.54.124.216-12384--
