Return-Path: <nanda74pg@rediffmail.com>
Date: 21 Nov 2008 14:16:10 -0000
MIME-Version: 1.0
To: <seh@zee2.com>
Message-ID: <DFTSgh6rR4.old.1227276970.57828@webmail.rediffmail.com>
Subject: Re :Re: [Ltib] ltib error -linux2.6.20.6 with MPC8360E MDS
From: "nanda" <nanda74pg@rediffmail.com>
Content-Type: multipart/alternative;
	boundary="=_a7538de2477de9b5de7536953cde5523"
Cc: Linuxppc-dev@ozlabs.org, Ltib@nongnu.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=_a7538de2477de9b5de7536953cde5523
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi Stuart,&nbsp;&nbsp; Thanks for the information.&nbsp;&nbsp; gpp access was resolved. &nbsp;&nbsp; I was successful in building the linux 2.6.11 using the ltib and able to bring up the MPC8360 EMDS.But, I still&nbsp;face the problem for linux kernel 2.6.19 and 2.6.20.&nbsp;&nbsp;&nbsp;When I tried using ltib in the&nbsp;bringing up the board.&nbsp;&nbsp;&nbsp;The MPC 8360 board keeps rebooting after downloading the image Power PC Kernel Image(uImage) and Power PC RAMDisk Image(rootfs.ext2.gz.uboot)&nbsp;&nbsp;build by the "ltib"&nbsp;&nbsp; &nbsp; Please clarrify on the same.Thanks in advance.Regards,Nanda&nbsp;&nbsp;On Thu, 20 Nov 2008 18:40:36 0000 Stuart Hughes wroteHi Nanda,This is happening because you don't have access tohttp://www.bitshrine.org/gpp for some reason.If LTIB needs to download sources to build a package, it will get themfrom bitshrine.org. Can you check that you are able to access this URLfrom the command line with wget.Regards, StuartOn Thu, 2008-11-20 at 18:30 0000, nanda wrote:&gt; Hi All,&gt; Iam forwarding the mail which I have posted to powerpc linux list&gt; Linuxppc-dev@ozlabs.org&gt; ===================================================&gt; &gt; Iam getting the below error during the generation of&gt; rootfs.ext2.gz.uboot (Power PC Linux RAM Disk Image) and uImage (Power&gt; PC Linux Kernel Image) for linux-2.6.20.6 kernel on the power PC MPC&gt; 8360E MDS using ltib tool.&gt; &gt; "Testing ppp_url connectivity: FAIL, disabling &gt; &gt; Testing gpp_url connectivity: FAIL, disabling &gt; &gt; No network download connection available"&gt; &gt; I did the following steps, but Iam unable to generate the&gt; rootfs.ext2.gz.uboot &gt; &gt; - In the ltib directory &gt; &gt; ./ltib --configure&gt; &gt; In the configure menu, I specified the following, before saving the&gt; configs&gt; &gt; - Tool chain as (gcc-3.4.3/glibc-2.3.3)&gt; &gt; - uboot 1.1.3&gt; &gt; - "Kernel (local linux directory build)" which refers to the local&gt; directory where linux-2.6.20.6 is placed&gt; &gt; - "Kernel config file"specified as mpc8360emds_defconfig, which is the&gt; file copied&gt; from /home/nanda/linux2.6.20.6/arch/powerpc/configs/mpc8360emds_defconfig to the ltib/config/platform/mpc8360epb directory) &gt; &gt; - Linux Target Architecture as "powerpc"&gt; &gt; After the above process by saving the configuration (it started&gt; building kernel and generated uImage) and failed in the below place&gt; (Refer also the attached build.txt file)&gt; &gt; ================================&gt; &gt; Processing: skell &gt; &gt; =================== &gt; &gt; Testing ppp_url connectivity: FAIL, disabling &gt; &gt; Testing gpp_url connectivity: FAIL, disabling &gt; &gt; No network download connection available&gt; &gt; Started: Thu Nov 20 14:44:45 2008 &gt; &gt; Ended: Thu Nov 20 14:57:32 2008 &gt; &gt; Elapsed: 767 seconds &gt; &gt; Build Failed&gt; &gt; =====================================&gt; &gt; I have attached the below files for boot and build logs with this&gt; mail, &gt; &gt; 1) defconfig.dev - default config generated for "./ltib configure"&gt; from config/platform/mpc8360epb &gt; &gt; 2) build.txt - Error build during "./ltib configure" output&gt; &gt; 3) mpc8360emds_defconfig - Default config file&gt; from /home/nanda/linux2.6.20.6/arch/powerpc/configs/ &gt; &gt; The end result was I could only see the uImage generated without&gt; rootfs.ext2.gz.uboot. Please clarify on the same &gt; &gt; Thanks in advance,&gt; &gt; Regards,&gt; &gt; Nanda&gt; _______________________________________________Linuxppc-dev mailing listLinuxppc-dev@ozlabs.orghttps://ozlabs.org/mailman/listinfo/linuxppc-dev
--=_a7538de2477de9b5de7536953cde5523
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Stuart,<br />&nbsp;&nbsp; Thanks for the information.&nbsp;&nbsp; gpp ac=
cess was resolved. <br />&nbsp;&nbsp; I was successful in building the linu=
x 2.6.11 using the ltib and able to bring up the MPC8360 EMDS.<br />But, I =
still&nbsp;face the problem for linux kernel 2.6.19 and 2.6.20.&nbsp;&nbsp;=
&nbsp;When I tried using ltib in the&nbsp;bringing up the board.&nbsp;<br /=
>&nbsp;&nbsp;The MPC 8360 board keeps rebooting after downloading the image=
 Power PC Kernel Image(uImage) and Power PC RAMDisk Image(rootfs.ext2.gz.ub=
oot)&nbsp;&nbsp;build by the "ltib"&nbsp;<br />&nbsp; &nbsp; Please clarrif=
y on the same.<br /><br />Thanks in advance.<br /><br />Regards,<br />Nanda=
<br /><br />&nbsp;<br /><br />&nbsp;<br />On Thu, 20 Nov 2008 18:40:36 0000=
 Stuart Hughes wrote<br />Hi Nanda,<br /><br />This is happening because yo=
u don't have access to<br />http://www.bitshrine.org/gpp for some reason.<b=
r /><br />If LTIB needs to download sources to build a package, it will get=
 them<br />from bitshrine.org. Can you check that you are able to access th=
is URL<br />from the command line with wget.<br /><br />Regards, Stuart<br =
/><br />On Thu, 2008-11-20 at 18:30 0000, nanda wrote:<br />&gt; Hi All,<br=
 />&gt; Iam forwarding the mail which I have posted to powerpc linux list<b=
r />&gt; Linuxppc-dev@ozlabs.org<br />&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br />&gt; <br />&gt; Iam g=
etting the below error during the generation of<br />&gt; rootfs.ext2.gz.ub=
oot (Power PC Linux RAM Disk Image) and uImage (Power<br />&gt; PC Linux Ke=
rnel Image) for linux-2.6.20.6 kernel on the power PC MPC<br />&gt; 8360E M=
DS using ltib tool.<br />&gt; <br />&gt; "Testing ppp_url connectivity: FAI=
L, disabling <br />&gt; <br />&gt; Testing gpp_url connectivity: FAIL, disa=
bling <br />&gt; <br />&gt; No network download connection available"<br />=
&gt; <br />&gt; I did the following steps, but Iam unable to generate the<b=
r />&gt; rootfs.ext2.gz.uboot <br />&gt; <br />&gt; - In the ltib directory=
 <br />&gt; <br />&gt; ./ltib --configure<br />&gt; <br />&gt; In the confi=
gure menu, I specified the following, before saving the<br />&gt; configs<b=
r />&gt; <br />&gt; - Tool chain as (gcc-3.4.3/glibc-2.3.3)<br />&gt; <br /=
>&gt; - uboot 1.1.3<br />&gt; <br />&gt; - "Kernel (local linux directory b=
uild)" which refers to the local<br />&gt; directory where linux-2.6.20.6 i=
s placed<br />&gt; <br />&gt; - "Kernel config file"specified as mpc8360emd=
s_defconfig, which is the<br />&gt; file copied<br />&gt; from /home/nanda/=
linux2.6.20.6/arch/powerpc/configs/mpc8360emds_defconfig to the ltib/config=
/platform/mpc8360epb directory) <br />&gt; <br />&gt; - Linux Target Archit=
ecture as "powerpc"<br />&gt; <br />&gt; After the above process by saving =
the configuration (it started<br />&gt; building kernel and generated uImag=
e) and failed in the below place<br />&gt; (Refer also the attached build.t=
xt file)<br />&gt; <br />&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br />&gt; <br />&gt; Pr=
ocessing: skell <br />&gt; <br />&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D <br />&gt; <br />&gt; Testing ppp_url connectivity: F=
AIL, disabling <br />&gt; <br />&gt; Testing gpp_url connectivity: FAIL, di=
sabling <br />&gt; <br />&gt; No network download connection available<br /=
>&gt; <br />&gt; Started: Thu Nov 20 14:44:45 2008 <br />&gt; <br />&gt; En=
ded: Thu Nov 20 14:57:32 2008 <br />&gt; <br />&gt; Elapsed: 767 seconds <b=
r />&gt; <br />&gt; Build Failed<br />&gt; <br />&gt; =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br />&gt; <br />&gt; I have attached the below files for bo=
ot and build logs with this<br />&gt; mail, <br />&gt; <br />&gt; 1) defcon=
fig.dev - default config generated for "./ltib configure"<br />&gt; from co=
nfig/platform/mpc8360epb <br />&gt; <br />&gt; 2) build.txt - Error build d=
uring "./ltib configure" output<br />&gt; <br />&gt; 3) mpc8360emds_defconf=
ig - Default config file<br />&gt; from /home/nanda/linux2.6.20.6/arch/powe=
rpc/configs/ <br />&gt; <br />&gt; The end result was I could only see the =
uImage generated without<br />&gt; rootfs.ext2.gz.uboot. Please clarify on =
the same <br />&gt; <br />&gt; Thanks in advance,<br />&gt; <br />&gt; Rega=
rds,<br />&gt; <br />&gt; Nanda<br />&gt; <br /><br /><br />_______________=
________________________________<br />Linuxppc-dev mailing list<br />Linuxp=
pc-dev@ozlabs.org<br />https://ozlabs.org/mailman/listinfo/linuxppc-dev<br =
/><br /><br><Table border=3D0 Width=3D644 Height=3D57 cellspacing=3D0 cellp=
adding=3D0 style=3D'font-family:Verdana;font-size:11px;line-height:15px;'><=
TR><td><a href=3D'http://adworks.rediff.com/cgi-bin/AdWorks/click.cgi/www.r=
ediff.com/signature-default.htm/1050715198@Middle5/2206641_2199021/2201651/=
1?PARTNER=3D3&OAS_QUERY=3Dnull' target=3Dnew ><img src =3D'http://imadworks=
.rediff.com/cgi-bin/AdWorks/adimage.cgi/2206641_2199021/creative_2201651.gi=
f'  alt=3D'Rediff Shopping'  border=3D0></a></td></TR></Table>
--=_a7538de2477de9b5de7536953cde5523--
