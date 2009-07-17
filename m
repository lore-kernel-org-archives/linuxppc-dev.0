Return-Path: <jerry_dw@126.com>
Received: from m15-32.126.com (m15-32.126.com [220.181.15.32])
	by bilbo.ozlabs.org (Postfix) with SMTP id E7D1BB6F35
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 12:25:06 +1000 (EST)
Date: Fri, 17 Jul 2009 09:53:52 +0800 (CST)
From: jerry_dw <jerry_dw@126.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <6174944.80871247795632146.JavaMail.coremail@bj126app32.126.com>
Subject: kernel2.6.30 can not boot on my mpc8260 board using u-boot2009.06
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_21592_21580633.1247795632144"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------=_Part_21592_21580633.1247795632144
Content-Type: multipart/alternative;
	boundary="----=_Part_21594_2759469.1247795632144"

------=_Part_21594_2759469.1247795632144
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit


Hi all: 
        My board is a custom MPC8260 board, with 4MB flash,128MB SDRAM.
I modified pq2fads.dts and pq2fads_defconfig,they are in the mail's accessory,
then compile the kernel.The kernel halt after displaying "Booting using OF flat tree.".
[u-boot]: bootm 1000000 2000000 3000000                                         
## Current stack ends at 0x07f9bd58                                             
*  kernel: cmdline image address = 0x01000000                                   
## Booting kernel from Legacy Image at 01000000 ...                             
   Image Name:   Linux-2.6.30                                                   
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)                   
   Data Size:    1510119 Bytes =  1.4 MB                                        
   Load Address: 00000000                                                       
   Entry Point:  00000000                                                       
   Verifying Checksum ... OK                                                    
   kernel data at 0x01000040, len = 0x00170ae7 (1510119)                        
*  ramdisk: cmdline image address = 0x02000000                                  
## Loading init Ramdisk from Legacy Image at 02000000 ...                       
   Image Name:   Simple Embedded Linux Framework                                
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)                  
   Data Size:    1730966 Bytes =  1.7 MB                                        
   Load Address: 00000000                                                       
   Entry Point:  00000000                                                       
   Verifying Checksum ... OK                                                    
   ramdisk start = 0x02000040, ramdisk end = 0x021a69d6                         
*  fdt: cmdline image address = 0x03000000                                      
## Checking for 'FDT'/'FDT Image' at 03000000                                   
*  fdt: raw FDT blob                                                            
## Flattened Device Tree blob at 03000000                                       
   Booting using the fdt blob at 0x3000000                                      
   of_flat_tree at 0x03000000 size 0x00003000                                   
   Uncompressing Kernel Image ... OK                                            
   kernel loaded at 0x00000000, end = 0x0030cc68                                
## initrd_high = 0xffffffff, copy_to_ram = 1                                    
   Loading Ramdisk to 07df4000, end 07f9a996 ... OK                             
   ramdisk load start = 0x07df4000, ramdisk load end = 0x07f9a996               
## device tree at 0x03000000 ... 0x03002FFF (len=24576=0x6000)                  
   Loading Device Tree to 007fa000, end 007fffff ... OK                         
Updating property 'current-speed' =  00 00 25 80                                
Updating property 'clock-frequency' =  01 79 a7 b0                              
Updating property 'bus-frequency' =  03 ef 14 80                                
Updating property 'timebase-frequency' =  00 00 00 00                           
Updating property 'clock-frequency' =  11 b3 dc 40                              
Updating property 'clock-frequency' =  03 ef 14 80                              
Updating property 'bus-frequency' =  03 ef 14 80                                
## Transferring control to Linux (at address 00000000) ...                      
   Booting using OF flat tree.

BDI2000 console:
MPC8260|:=>halt
    Target CPU        : MPC82xx (G2H4)
    Target state      : debug mode
    Debug entry cause : COP halt
    Current PC        : 0xc000c5f0
    Current CR        : 0x42022088
    Current MSR       : 0x00001032
    Current LR        : 0xc001cfa8

0xc000c5f0: in hardwareinterrupt vector table.

Does anyone have an idea about what is going wrong? 
Is the error in my u-boot, device tree blob or linux kernel side? 
what i should look at? 

Best regards.
Dewen



------=_Part_21594_2759469.1247795632144
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<div><br>Hi all: <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; My board is=
 a custom MPC8260 board, with 4MB flash,128MB SDRAM.<br>I modified pq2fads.=
dts and pq2fads_defconfig,they are in the mail's accessory,<br>then compile=
 the kernel.The kernel halt after displaying "Booting using OF flat tree.".=
<br>[u-boot]: bootm 1000000 2000000 3000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>## Current s=
tack ends at 0x07f9bd58&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>*&nbsp; =
kernel: cmdline image address =3D 0x01000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; <br>## Booting kernel from Legacy Image at 01000000=
 ...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.3=
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip=
 compressed)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp; Data Size:&n=
bsp;&nbsp;&nbsp; 1510119 Bytes =3D&nbsp; 1.4 MB&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp; L=
oad Address: 00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp; Entry Point:=
&nbsp; 00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp; Verifying Checksum=
 ... OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <br>&nbsp;&nbsp; kernel data at 0x01000040, len =3D 0x00170ae=
7 (1510119)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<br>*&nbsp; ramdisk: cmdline image address =3D 0x02000000&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>## Loading init Ramdisk from Legacy Imag=
e at 02000000 ...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Simple Embedded Linux Framework&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; =
PowerPC Linux RAMDisk Image (gzip compressed)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b=
r>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1730966 Bytes =3D&nbsp; 1.7 MB&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; <br>&nbsp;&nbsp; Load Address: 00000000&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b=
r>&nbsp;&nbsp; Entry Point:&nbsp; 00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbs=
p;&nbsp; Verifying Checksum ... OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp; ramdisk start =3D=
 0x02000040, ramdisk end =3D 0x021a69d6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>*&nbsp; fdt: cmdline image address =
=3D 0x03000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; <br>## Checking for 'FDT'/'FDT Image' at 03000000&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>*&nbsp; fdt: raw FDT blob&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>## Flattened Device T=
ree blob at 03000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp; Booting using the fdt blob at 0x30=
00000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; <br>&nbsp;&nbsp; of_flat_tree at 0x03000000 size 0x00003000&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp; Uncompressing Ke=
rnel Image ... OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp; kernel =
loaded at 0x00000000, end =3D 0x0030cc68&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <br>## initrd_high =3D 0xffffffff, copy_to_ram =3D 1&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp; Loading Ramdisk to=
 07df4000, end 07f9a996 ... OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp; ramdisk l=
oad start =3D 0x07df4000, ramdisk load end =3D 0x07f9a996&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>## d=
evice tree at 0x03000000 ... 0x03002FFF (len=3D24576=3D0x6000)&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; <br>&nbsp;&nbsp; Loading Device Tree to 007fa000, end 007fff=
ff ... OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; <br>Updating property 'current-speed' =3D&nbsp; 00 00 25 80&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; <br>Updating property 'clock-frequency' =3D&nbsp; =
01 79 a7 b0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>Updating property 'bus-frequency' =
=3D&nbsp; 03 ef 14 80&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>Updating prop=
erty 'timebase-frequency' =3D&nbsp; 00 00 00 00&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>Updating property=
 'clock-frequency' =3D&nbsp; 11 b3 dc 40&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>Updati=
ng property 'clock-frequency' =3D&nbsp; 03 ef 14 80&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 <br>Updating property 'bus-frequency' =3D&nbsp; 03 ef 14 80&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; <br>## Transferring control to Linux (at address 0000=
0000) ...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbs=
p; Booting using OF flat tree.<br><br> BDI2000 console:<br>MPC8260|:=3D&gt;=
halt<br>&nbsp;&nbsp;&nbsp; Target CPU&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; : MPC82xx (G2H4)<br>&nbsp;&nbsp;&nbsp; Target state&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; : debug mode<br>&nbsp;&nbsp;&nbsp; Debug entry cause : COP halt=
<br>&nbsp;&nbsp;&nbsp; Current PC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 : 0xc000c5f0<br>&nbsp;&nbsp;&nbsp; Current CR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; : 0x42022088<br>&nbsp;&nbsp;&nbsp; Current MSR&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; : 0x00001032<br>&nbsp;&nbsp;&nbsp; Current LR&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0xc001cfa8<br><br>0xc000c5f0: in hardw=
areinterrupt vector table.<br><br>Does anyone have an idea about what is go=
ing wrong?
<br>Is the error in my u-boot, device tree blob or linux kernel side?
<br>what i should look at?
<br><br>Best regards.<br>Dewen<br><br><br></div><br><!-- footer --><br><spa=
n title=3D"neteasefooter"/><hr/>
<a href=3D"http://count.mail.163.com/redirect/footer.htm?f=3Dhttp://gouwu.y=
oudao.com">200=CD=F2=D6=D6=C9=CC=C6=B7,=D7=EE=B5=CD=BC=DB=B8=F1,=B7=E8=BF=
=F1=D3=D5=BB=F3=C4=E3</a>
</span>
------=_Part_21594_2759469.1247795632144--

------=_Part_21592_21580633.1247795632144
Content-Type: application/octet-stream; name="pq2fads.dts"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pq2fads.dts"

LyoKICogRGV2aWNlIFRyZWUgZm9yIHRoZSBQUTJGQURTLVpVIGJvYXJkIHdpdGggYW4gTVBDODI4
MCBjaGlwLgogKgogKiBDb3B5cmlnaHQgMjAwNywyMDA4IEZyZWVzY2FsZSBTZW1pY29uZHVjdG9y
IEluYy4KICoKICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0
cmlidXRlICBpdCBhbmQvb3IgbW9kaWZ5IGl0CiAqIHVuZGVyICB0aGUgdGVybXMgb2YgIHRoZSBH
TlUgR2VuZXJhbCAgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5IHRoZQogKiBGcmVlIFNv
ZnR3YXJlIEZvdW5kYXRpb247ICBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSAgTGljZW5zZSwgb3Ig
KGF0IHlvdXIKICogb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KICovCgovZHRzLXYxLzsKCi8g
ewoJbW9kZWwgPSAicHEyZmFkcyI7Cgljb21wYXRpYmxlID0gImZzbCxwcTJmYWRzIjsKCSNhZGRy
ZXNzLWNlbGxzID0gPDE+OwoJI3NpemUtY2VsbHMgPSA8MT47CgoJYWxpYXNlcyB7CgkJZXRoZXJu
ZXQwID0gJmVuZXQwOwoJCXNlcmlhbDAgPSAmc2VyaWFsMDsKCX07CgoJY3B1cyB7CgkJI2FkZHJl
c3MtY2VsbHMgPSA8MT47CgkJI3NpemUtY2VsbHMgPSA8MD47CgoJCVBvd2VyUEMsODI2MEAwIHsK
CQkJZGV2aWNlX3R5cGUgPSAiY3B1IjsKCQkJcmVnID0gPDB4MD47CgkJCWQtY2FjaGUtbGluZS1z
aXplID0gPDMyPjsKCQkJaS1jYWNoZS1saW5lLXNpemUgPSA8MzI+OwoJCQlkLWNhY2hlLXNpemUg
PSA8MTYzODQ+OwoJCQlpLWNhY2hlLXNpemUgPSA8MTYzODQ+OwoJCQl0aW1lYmFzZS1mcmVxdWVu
Y3kgPSA8MD47CgkJCWNsb2NrLWZyZXF1ZW5jeSA9IDwwPjsKCQl9OwoJfTsKCgltZW1vcnkgewoJ
CWRldmljZV90eXBlID0gIm1lbW9yeSI7CgkJcmVnID0gPDB4MCAweDgwMDAwMDA+OwoJfTsKCgls
b2NhbGJ1c0BmMDAxMDEwMCB7CgkJY29tcGF0aWJsZSA9ICJmc2wsbXBjODI4MC1sb2NhbGJ1cyIs
CgkJICAgICAgICAgICAgICJmc2wscHEyLWxvY2FsYnVzIjsKCQkjYWRkcmVzcy1jZWxscyA9IDwy
PjsKCQkjc2l6ZS1jZWxscyA9IDwxPjsKCQlyZWcgPSA8MHhmMDAxMDEwMCAweDYwPjsKCgkJcmFu
Z2VzID0gPDB4MCAweDAgMHgyMDAwMDAwMCAweDQwMDAwMAoJCSAgICAgICAgICAweDEgMHgwIDB4
ZmUwMDAwMDAgMHg4MDAwPjsKCgkJZmxhc2hAMCwwIHsKCQkJY29tcGF0aWJsZSA9ImludGVsLDI4
ZjE2MCIsImplZGVjLWZsYXNoIjsKCQkJcmVnID0gPDB4MCAweDAgMHg0MDAwMDA+OwoJCQliYW5r
LXdpZHRoID0gPDQ+OwoJCQlkZXZpY2Utd2lkdGggPSA8MT47CgkJCXVib290QDAgewoJCQkJbGFi
ZWwgPSAidWJvb3QiOwoJCQkJcmVnID0gPDAgMHg0MDAwMD47CgkJCX07CgkJCXVJbWFnZUA0MDAw
MCB7CgkJCQlsYWJlbCA9ICJ1aW1hZ2UiOwoJCQkJcmVnID0gPDB4NDAwMDAgMHgxQTAwMDA+OwoJ
CQl9OwoJCQlyYW1kaXNrQDIwMDAwMCB7CgkJCQlsYWJlbCA9ICJyYW1kaXNrIjsKCQkJCXJlZyA9
IDwweDIwMDAwMCAweDEwMDAwMD47CgkJCX07CgoJCX07CgoJCWJjc3JAMSwwIHsKCQkJcmVnID0g
PDB4MSAweDAgMHgyMD47CgkJCWNvbXBhdGlibGUgPSAiZnNsLHBxMmZhZHMtYmNzciI7CgkJfTsK
Cgl9OwoKCXNvY0BmMDAwMDAwMCB7CgkJI2FkZHJlc3MtY2VsbHMgPSA8MT47CgkJI3NpemUtY2Vs
bHMgPSA8MT47CgkJZGV2aWNlX3R5cGUgPSAic29jIjsKCQljb21wYXRpYmxlID0gImZzbCxtcGM4
MjgwIiwgImZzbCxwcTItc29jIjsKCQlyYW5nZXMgPSA8MHgwIDB4ZjAwMDAwMDAgMHg1MzAwMD47
CgoJCS8vIFRlbXBvcmFyeSAtLSB3aWxsIGdvIGF3YXkgb25jZSBrZXJuZWwgdXNlcyByYW5nZXMg
Zm9yIGdldF9pbW1yYmFzZSgpLgoJCXJlZyA9IDwweGYwMDAwMDAwIDB4NTMwMDA+OwoKCQljcG1A
MTE5YzAgewoJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKCQkJI3NpemUtY2VsbHMgPSA8MT47CgkJ
CSNpbnRlcnJ1cHQtY2VsbHMgPSA8Mj47CgkJCWNvbXBhdGlibGUgPSAiZnNsLG1wYzgyODAtY3Bt
IiwgImZzbCxjcG0yIjsKCQkJcmVnID0gPDB4MTE5YzAgMHgzMD47CgkJCXJhbmdlczsKCgkJCW11
cmFtQDAgewoJCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47CgkJCQkjc2l6ZS1jZWxscyA9IDwxPjsK
CQkJCXJhbmdlcyA9IDwweDAgMHgwIDB4MTAwMDA+OwoKCQkJCWRhdGFAMCB7CgkJCQkJY29tcGF0
aWJsZSA9ICJmc2wsY3BtLW11cmFtLWRhdGEiOwoJCQkJCXJlZyA9IDwweDAgMHgyMDAwIDB4OTgw
MCAweDgwMD47CgkJCQl9OwoJCQl9OwoKCQkJYnJnQDExOWYwIHsKCQkJCWNvbXBhdGlibGUgPSAi
ZnNsLG1wYzgyODAtYnJnIiwKCQkJCSAgICAgICAgICAgICAiZnNsLGNwbTItYnJnIiwKCQkJCSAg
ICAgICAgICAgICAiZnNsLGNwbS1icmciOwoJCQkJcmVnID0gPDB4MTE5ZjAgMHgxMCAweDExNWYw
IDB4MTA+OwoJCQl9OwoKCQkJc2VyaWFsMDogc2VyaWFsQDExYTAwIHsKCQkJCWRldmljZV90eXBl
ID0gInNlcmlhbCI7CgkJCQljb21wYXRpYmxlID0gImZzbCxtcGM4MjgwLXNjYy11YXJ0IiwKCQkJ
CSAgICAgICAgICAgICAiZnNsLGNwbTItc2NjLXVhcnQiOwoJCQkJcmVnID0gPDB4MTFhMDAgMHgy
MCAweDgwMDAgMHgxMDA+OwoJCQkJaW50ZXJydXB0cyA9IDw0MCA4PjsKCQkJCWludGVycnVwdC1w
YXJlbnQgPSA8JlBJQz47CgkJCQlmc2wsY3BtLWJyZyA9IDwxPjsKCQkJCWZzbCxjcG0tY29tbWFu
ZCA9IDwweDgwMDAwMD47CgkJCX07CgoJCQllbmV0MDogZXRoZXJuZXRAMTEzMjAgewoJCQkJZGV2
aWNlX3R5cGUgPSAibmV0d29yayI7CgkJCQljb21wYXRpYmxlID0gImZzbCxtcGM4MjgwLWZjYy1l
bmV0IiwKCQkJCSAgICAgICAgICAgICAiZnNsLGNwbTItZmNjLWVuZXQiOwoJCQkJcmVnID0gPDB4
MTEzMjAgMHgyMCAweDg1MDAgMHgxMDAgMHgxMTNiMCAweDE+OwoJCQkJaW50ZXJydXB0cyA9IDwz
MyA4PjsKCQkJCWludGVycnVwdC1wYXJlbnQgPSA8JlBJQz47CgkJCQlwaHktaGFuZGxlID0gPCZQ
SFkwPjsKCQkJCWxpbnV4LG5ldHdvcmstaW5kZXggPSA8MD47CgkJCQlmc2wsY3BtLWNvbW1hbmQg
PSA8MHgxNjIwMDMwMD47CgkJCX07CgoJCQltZGlvQDEwZDQwIHsKCQkJCWRldmljZV90eXBlID0g
Im1kaW8iOwoJCQkJY29tcGF0aWJsZSA9ICJmc2wscHEyZmFkcy1tZGlvLWJpdGJhbmciLAoJCQkJ
ICAgICAgICAgICAgICJmc2wsbXBjODI4MC1tZGlvLWJpdGJhbmciLAoJCQkJICAgICAgICAgICAg
ICJmc2wsY3BtMi1tZGlvLWJpdGJhbmciOwoJCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47CgkJCQkj
c2l6ZS1jZWxscyA9IDwwPjsKCQkJCXJlZyA9IDwweDEwZDQwIDB4MTQ+OwoJCQkJZnNsLG1kaW8t
cGluID0gPDk+OwoJCQkJZnNsLG1kYy1waW4gPSA8MTA+OwoKCQkJCVBIWTA6IGV0aGVybmV0LXBo
eUAwIHsKCQkJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZQSUM+OwoJCQkJCWludGVycnVwdHMgPSA8
MjUgMj47CgkJCQkJcmVnID0gPDB4MD47CgkJCQkJZGV2aWNlX3R5cGUgPSAiZXRoZXJuZXQtcGh5
IjsKCQkJCX07CgkJCX07CgkJfTsKCgkJUElDOiBpbnRlcnJ1cHQtY29udHJvbGxlckAxMGMwMCB7
CgkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8Mj47CgkJCWludGVycnVwdC1jb250cm9sbGVyOwoJCQly
ZWcgPSA8MHgxMGMwMCAweDgwPjsKCQkJY29tcGF0aWJsZSA9ICJmc2wsbXBjODI4MC1waWMiLCAi
ZnNsLGNwbTItcGljIjsKCQl9OwoJfTsKCgljaG9zZW4gewoJCWxpbnV4LHN0ZG91dC1wYXRoID0g
Ii9zb2MvY3BtL3NlcmlhbEAxMWEwMCI7CgkJYm9vdGFyZ3M9ImNvbnNvbGU9dHR5Q1BNMCw5NjAw
IHJvb3Q9L2Rldi9yYW0wIjsKCX07Cn07Cg==
------=_Part_21592_21580633.1247795632144
Content-Type: application/octet-stream; name="pq2fads_defconfig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pq2fads_defconfig"

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMgTGlu
dXgga2VybmVsIHZlcnNpb246IDIuNi4zMAojIFRodSBKdWwgMTYgMTY6MzA6MzcgMjAwOQojCiMg
Q09ORklHX1BQQzY0IGlzIG5vdCBzZXQKCiMKIyBQcm9jZXNzb3Igc3VwcG9ydAojCkNPTkZJR182
eHg9eQojIENPTkZJR19QUENfODV4eCBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ184eHggaXMgbm90
IHNldAojIENPTkZJR180MHggaXMgbm90IHNldAojIENPTkZJR180NHggaXMgbm90IHNldAojIENP
TkZJR19FMjAwIGlzIG5vdCBzZXQKQ09ORklHX1BQQ19CT09LM1M9eQpDT05GSUdfUFBDX0ZQVT15
CiMgQ09ORklHX0FMVElWRUMgaXMgbm90IHNldApDT05GSUdfUFBDX1NURF9NTVU9eQpDT05GSUdf
UFBDX1NURF9NTVVfMzI9eQojIENPTkZJR19QUENfTU1fU0xJQ0VTIGlzIG5vdCBzZXQKIyBDT05G
SUdfU01QIGlzIG5vdCBzZXQKQ09ORklHX1BQQzMyPXkKQ09ORklHX1dPUkRfU0laRT0zMgojIENP
TkZJR19BUkNIX1BIWVNfQUREUl9UXzY0QklUIGlzIG5vdCBzZXQKQ09ORklHX01NVT15CkNPTkZJ
R19HRU5FUklDX0NNT1NfVVBEQVRFPXkKQ09ORklHX0dFTkVSSUNfVElNRT15CkNPTkZJR19HRU5F
UklDX1RJTUVfVlNZU0NBTEw9eQpDT05GSUdfR0VORVJJQ19DTE9DS0VWRU5UUz15CkNPTkZJR19H
RU5FUklDX0hBUkRJUlFTPXkKIyBDT05GSUdfSEFWRV9TRVRVUF9QRVJfQ1BVX0FSRUEgaXMgbm90
IHNldApDT05GSUdfSVJRX1BFUl9DUFU9eQpDT05GSUdfU1RBQ0tUUkFDRV9TVVBQT1JUPXkKQ09O
RklHX0hBVkVfTEFURU5DWVRPUF9TVVBQT1JUPXkKQ09ORklHX0xPQ0tERVBfU1VQUE9SVD15CkNP
TkZJR19SV1NFTV9YQ0hHQUREX0FMR09SSVRITT15CkNPTkZJR19BUkNIX0hBU19JTE9HMl9VMzI9
eQpDT05GSUdfR0VORVJJQ19IV0VJR0hUPXkKQ09ORklHX0dFTkVSSUNfQ0FMSUJSQVRFX0RFTEFZ
PXkKQ09ORklHX0dFTkVSSUNfRklORF9ORVhUX0JJVD15CkNPTkZJR19HRU5FUklDX0dQSU89eQoj
IENPTkZJR19BUkNIX05PX1ZJUlRfVE9fQlVTIGlzIG5vdCBzZXQKQ09ORklHX1BQQz15CkNPTkZJ
R19FQVJMWV9QUklOVEs9eQpDT05GSUdfR0VORVJJQ19OVlJBTT15CkNPTkZJR19TQ0hFRF9PTUlU
X0ZSQU1FX1BPSU5URVI9eQpDT05GSUdfQVJDSF9NQVlfSEFWRV9QQ19GREM9eQpDT05GSUdfUFBD
X09GPXkKQ09ORklHX09GPXkKIyBDT05GSUdfUFBDX1VEQkdfMTY1NTAgaXMgbm90IHNldAojIENP
TkZJR19HRU5FUklDX1RCU1lOQyBpcyBub3Qgc2V0CkNPTkZJR19BVURJVF9BUkNIPXkKQ09ORklH
X0dFTkVSSUNfQlVHPXkKQ09ORklHX0RUQz15CkNPTkZJR19ERUZBVUxUX1VJTUFHRT15CiMgQ09O
RklHX1BQQ19EQ1JfTkFUSVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX0RDUl9NTUlPIGlzIG5v
dCBzZXQKQ09ORklHX0FSQ0hfU1VQUE9SVFNfREVCVUdfUEFHRUFMTE9DPXkKQ09ORklHX0RFRkNP
TkZJR19MSVNUPSIvbGliL21vZHVsZXMvJFVOQU1FX1JFTEVBU0UvLmNvbmZpZyIKCiMKIyBHZW5l
cmFsIHNldHVwCiMKIyBDT05GSUdfRVhQRVJJTUVOVEFMIGlzIG5vdCBzZXQKQ09ORklHX0JST0tF
Tl9PTl9TTVA9eQpDT05GSUdfSU5JVF9FTlZfQVJHX0xJTUlUPTMyCkNPTkZJR19MT0NBTFZFUlNJ
T049IiIKQ09ORklHX0xPQ0FMVkVSU0lPTl9BVVRPPXkKQ09ORklHX1NXQVA9eQpDT05GSUdfU1lT
VklQQz15CkNPTkZJR19TWVNWSVBDX1NZU0NUTD15CiMgQ09ORklHX0JTRF9QUk9DRVNTX0FDQ1Qg
aXMgbm90IHNldAojIENPTkZJR19UQVNLU1RBVFMgaXMgbm90IHNldAojIENPTkZJR19BVURJVCBp
cyBub3Qgc2V0CgojCiMgUkNVIFN1YnN5c3RlbQojCkNPTkZJR19DTEFTU0lDX1JDVT15CiMgQ09O
RklHX1RSRUVfUkNVIGlzIG5vdCBzZXQKIyBDT05GSUdfUFJFRU1QVF9SQ1UgaXMgbm90IHNldAoj
IENPTkZJR19UUkVFX1JDVV9UUkFDRSBpcyBub3Qgc2V0CiMgQ09ORklHX1BSRUVNUFRfUkNVX1RS
QUNFIGlzIG5vdCBzZXQKQ09ORklHX0lLQ09ORklHPXkKQ09ORklHX0lLQ09ORklHX1BST0M9eQpD
T05GSUdfTE9HX0JVRl9TSElGVD0xNAojIENPTkZJR19DR1JPVVBTIGlzIG5vdCBzZXQKQ09ORklH
X1NZU0ZTX0RFUFJFQ0FURUQ9eQpDT05GSUdfU1lTRlNfREVQUkVDQVRFRF9WMj15CiMgQ09ORklH
X1JFTEFZIGlzIG5vdCBzZXQKIyBDT05GSUdfTkFNRVNQQUNFUyBpcyBub3Qgc2V0CkNPTkZJR19C
TEtfREVWX0lOSVRSRD15CkNPTkZJR19JTklUUkFNRlNfU09VUkNFPSIiCkNPTkZJR19SRF9HWklQ
PXkKIyBDT05GSUdfUkRfQlpJUDIgaXMgbm90IHNldAojIENPTkZJR19SRF9MWk1BIGlzIG5vdCBz
ZXQKQ09ORklHX0NDX09QVElNSVpFX0ZPUl9TSVpFPXkKQ09ORklHX1NZU0NUTD15CkNPTkZJR19B
Tk9OX0lOT0RFUz15CkNPTkZJR19FTUJFRERFRD15CkNPTkZJR19TWVNDVExfU1lTQ0FMTD15CkNP
TkZJR19LQUxMU1lNUz15CkNPTkZJR19LQUxMU1lNU19BTEw9eQojIENPTkZJR19LQUxMU1lNU19F
WFRSQV9QQVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfU1RSSVBfQVNNX1NZTVMgaXMgbm90IHNldApD
T05GSUdfSE9UUExVRz15CkNPTkZJR19QUklOVEs9eQpDT05GSUdfQlVHPXkKQ09ORklHX0VMRl9D
T1JFPXkKQ09ORklHX0JBU0VfRlVMTD15CkNPTkZJR19GVVRFWD15CkNPTkZJR19FUE9MTD15CkNP
TkZJR19TSUdOQUxGRD15CkNPTkZJR19USU1FUkZEPXkKQ09ORklHX0VWRU5URkQ9eQpDT05GSUdf
U0hNRU09eQpDT05GSUdfQUlPPXkKQ09ORklHX1ZNX0VWRU5UX0NPVU5URVJTPXkKQ09ORklHX1NM
VUJfREVCVUc9eQpDT05GSUdfQ09NUEFUX0JSSz15CiMgQ09ORklHX1NMQUIgaXMgbm90IHNldApD
T05GSUdfU0xVQj15CiMgQ09ORklHX1NMT0IgaXMgbm90IHNldAojIENPTkZJR19QUk9GSUxJTkcg
aXMgbm90IHNldAojIENPTkZJR19NQVJLRVJTIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfT1BST0ZJ
TEU9eQpDT05GSUdfSEFWRV9FRkZJQ0lFTlRfVU5BTElHTkVEX0FDQ0VTUz15CkNPTkZJR19IQVZF
X0lPUkVNQVBfUFJPVD15CkNPTkZJR19IQVZFX0tQUk9CRVM9eQpDT05GSUdfSEFWRV9LUkVUUFJP
QkVTPXkKQ09ORklHX0hBVkVfQVJDSF9UUkFDRUhPT0s9eQpDT05GSUdfSEFWRV9DTEs9eQojIENP
TkZJR19TTE9XX1dPUksgaXMgbm90IHNldAojIENPTkZJR19IQVZFX0dFTkVSSUNfRE1BX0NPSEVS
RU5UIGlzIG5vdCBzZXQKQ09ORklHX1NMQUJJTkZPPXkKQ09ORklHX1JUX01VVEVYRVM9eQpDT05G
SUdfQkFTRV9TTUFMTD0wCiMgQ09ORklHX01PRFVMRVMgaXMgbm90IHNldApDT05GSUdfQkxPQ0s9
eQojIENPTkZJR19MQkQgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0lOVEVHUklUWSBpcyBu
b3Qgc2V0CgojCiMgSU8gU2NoZWR1bGVycwojCkNPTkZJR19JT1NDSEVEX05PT1A9eQpDT05GSUdf
SU9TQ0hFRF9BUz15CkNPTkZJR19JT1NDSEVEX0RFQURMSU5FPXkKQ09ORklHX0lPU0NIRURfQ0ZR
PXkKQ09ORklHX0RFRkFVTFRfQVM9eQojIENPTkZJR19ERUZBVUxUX0RFQURMSU5FIGlzIG5vdCBz
ZXQKIyBDT05GSUdfREVGQVVMVF9DRlEgaXMgbm90IHNldAojIENPTkZJR19ERUZBVUxUX05PT1Ag
aXMgbm90IHNldApDT05GSUdfREVGQVVMVF9JT1NDSEVEPSJhbnRpY2lwYXRvcnkiCiMgQ09ORklH
X0ZSRUVaRVIgaXMgbm90IHNldAoKIwojIFBsYXRmb3JtIHN1cHBvcnQKIwojIENPTkZJR19QUENf
Q0hSUCBpcyBub3Qgc2V0CiMgQ09ORklHX01QQzUxMjFfQURTIGlzIG5vdCBzZXQKIyBDT05GSUdf
TVBDNTEyMV9HRU5FUklDIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX01QQzUyeHggaXMgbm90IHNl
dAojIENPTkZJR19QUENfUE1BQyBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ19DRUxMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUFBDX0NFTExfTkFUSVZFIGlzIG5vdCBzZXQKQ09ORklHX1BQQ184Mnh4PXkK
IyBDT05GSUdfTVBDODI3Ml9BRFMgaXMgbm90IHNldApDT05GSUdfUFEyRkFEUz15CiMgQ09ORklH
X0VQODI0OEUgaXMgbm90IHNldAojIENPTkZJR19NR0NPR0UgaXMgbm90IHNldApDT05GSUdfUFEy
QURTPXkKQ09ORklHXzgyNjA9eQojIENPTkZJR19QUENfODN4eCBpcyBub3Qgc2V0CiMgQ09ORklH
X1BQQ184Nnh4IGlzIG5vdCBzZXQKIyBDT05GSUdfRU1CRURERUQ2eHggaXMgbm90IHNldAojIENP
TkZJR19BTUlHQU9ORSBpcyBub3Qgc2V0CkNPTkZJR19QUENfT0ZfQk9PVF9UUkFNUE9MSU5FPXkK
IyBDT05GSUdfSVBJQyBpcyBub3Qgc2V0CiMgQ09ORklHX01QSUMgaXMgbm90IHNldAojIENPTkZJ
R19NUElDX1dFSVJEIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX0k4MjU5IGlzIG5vdCBzZXQKIyBD
T05GSUdfUFBDX1JUQVMgaXMgbm90IHNldAojIENPTkZJR19NTUlPX05WUkFNIGlzIG5vdCBzZXQK
IyBDT05GSUdfUFBDX01QQzEwNiBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ185NzBfTkFQIGlzIG5v
dCBzZXQKIyBDT05GSUdfUFBDX0lORElSRUNUX0lPIGlzIG5vdCBzZXQKIyBDT05GSUdfR0VORVJJ
Q19JT01BUCBpcyBub3Qgc2V0CiMgQ09ORklHX0NQVV9GUkVRIGlzIG5vdCBzZXQKIyBDT05GSUdf
VEFVIGlzIG5vdCBzZXQKQ09ORklHX1FVSUNDX0VOR0lORT15CkNPTkZJR19RRV9HUElPPXkKQ09O
RklHX0NQTTI9eQojIENPTkZJR19GU0xfVUxJMTU3NSBpcyBub3Qgc2V0CkNPTkZJR19DUE09eQpD
T05GSUdfU0lNUExFX0dQSU89eQoKIwojIEtlcm5lbCBvcHRpb25zCiMKIyBDT05GSUdfSElHSE1F
TSBpcyBub3Qgc2V0CkNPTkZJR19USUNLX09ORVNIT1Q9eQpDT05GSUdfTk9fSFo9eQpDT05GSUdf
SElHSF9SRVNfVElNRVJTPXkKQ09ORklHX0dFTkVSSUNfQ0xPQ0tFVkVOVFNfQlVJTEQ9eQojIENP
TkZJR19IWl8xMDAgaXMgbm90IHNldApDT05GSUdfSFpfMjUwPXkKIyBDT05GSUdfSFpfMzAwIGlz
IG5vdCBzZXQKIyBDT05GSUdfSFpfMTAwMCBpcyBub3Qgc2V0CkNPTkZJR19IWj0yNTAKQ09ORklH
X1NDSEVEX0hSVElDSz15CkNPTkZJR19QUkVFTVBUX05PTkU9eQojIENPTkZJR19QUkVFTVBUX1ZP
TFVOVEFSWSBpcyBub3Qgc2V0CiMgQ09ORklHX1BSRUVNUFQgaXMgbm90IHNldApDT05GSUdfQklO
Rk1UX0VMRj15CiMgQ09ORklHX0NPUkVfRFVNUF9ERUZBVUxUX0VMRl9IRUFERVJTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSEFWRV9BT1VUIGlzIG5vdCBzZXQKQ09ORklHX0JJTkZNVF9NSVNDPXkKIyBD
T05GSUdfSU9NTVVfSEVMUEVSIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfRU5BQkxFX01FTU9SWV9I
T1RQTFVHPXkKQ09ORklHX0FSQ0hfSEFTX1dBTEtfTUVNT1JZPXkKQ09ORklHX0FSQ0hfRU5BQkxF
X01FTU9SWV9IT1RSRU1PVkU9eQojIENPTkZJR19DUkFTSF9EVU1QIGlzIG5vdCBzZXQKQ09ORklH
X0FSQ0hfRkxBVE1FTV9FTkFCTEU9eQpDT05GSUdfQVJDSF9QT1BVTEFURVNfTk9ERV9NQVA9eQpD
T05GSUdfRkxBVE1FTT15CkNPTkZJR19GTEFUX05PREVfTUVNX01BUD15CkNPTkZJR19QQUdFRkxB
R1NfRVhURU5ERUQ9eQpDT05GSUdfU1BMSVRfUFRMT0NLX0NQVVM9NApDT05GSUdfTUlHUkFUSU9O
PXkKIyBDT05GSUdfUEhZU19BRERSX1RfNjRCSVQgaXMgbm90IHNldApDT05GSUdfWk9ORV9ETUFf
RkxBRz0xCkNPTkZJR19CT1VOQ0U9eQpDT05GSUdfVklSVF9UT19CVVM9eQpDT05GSUdfVU5FVklD
VEFCTEVfTFJVPXkKQ09ORklHX0hBVkVfTUxPQ0s9eQpDT05GSUdfSEFWRV9NTE9DS0VEX1BBR0Vf
QklUPXkKQ09ORklHX1BQQ180S19QQUdFUz15CiMgQ09ORklHX1BQQ18xNktfUEFHRVMgaXMgbm90
IHNldAojIENPTkZJR19QUENfNjRLX1BBR0VTIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDXzI1Nktf
UEFHRVMgaXMgbm90IHNldApDT05GSUdfRk9SQ0VfTUFYX1pPTkVPUkRFUj0xMQpDT05GSUdfUFJP
Q19ERVZJQ0VUUkVFPXkKIyBDT05GSUdfQ01ETElORV9CT09MIGlzIG5vdCBzZXQKQ09ORklHX0VY
VFJBX1RBUkdFVFM9IiIKIyBDT05GSUdfUE0gaXMgbm90IHNldApDT05GSUdfU0VDQ09NUD15CkNP
TkZJR19JU0FfRE1BX0FQST15CgojCiMgQnVzIG9wdGlvbnMKIwpDT05GSUdfWk9ORV9ETUE9eQpD
T05GSUdfRlNMX1NPQz15CkNPTkZJR19QUENfUENJX0NIT0lDRT15CiMgQ09ORklHX1BDSSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BDSV9ET01BSU5TIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJX1NZU0NB
TEwgaXMgbm90IHNldAojIENPTkZJR19BUkNIX1NVUFBPUlRTX01TSSBpcyBub3Qgc2V0CiMgQ09O
RklHX1BDQ0FSRCBpcyBub3Qgc2V0CiMgQ09ORklHX0hBU19SQVBJRElPIGlzIG5vdCBzZXQKCiMK
IyBBZHZhbmNlZCBzZXR1cAojCiMgQ09ORklHX0FEVkFOQ0VEX09QVElPTlMgaXMgbm90IHNldAoK
IwojIERlZmF1bHQgc2V0dGluZ3MgZm9yIGFkdmFuY2VkIGNvbmZpZ3VyYXRpb24gb3B0aW9ucyBh
cmUgdXNlZAojCkNPTkZJR19MT1dNRU1fU0laRT0weDMwMDAwMDAwCkNPTkZJR19QQUdFX09GRlNF
VD0weGMwMDAwMDAwCkNPTkZJR19LRVJORUxfU1RBUlQ9MHhjMDAwMDAwMApDT05GSUdfUEhZU0lD
QUxfU1RBUlQ9MHgwMDAwMDAwMApDT05GSUdfVEFTS19TSVpFPTB4YzAwMDAwMDAKQ09ORklHX05F
VD15CgojCiMgTmV0d29ya2luZyBvcHRpb25zCiMKQ09ORklHX1BBQ0tFVD15CiMgQ09ORklHX1BB
Q0tFVF9NTUFQIGlzIG5vdCBzZXQKQ09ORklHX1VOSVg9eQpDT05GSUdfWEZSTT15CiMgQ09ORklH
X1hGUk1fVVNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9LRVkgaXMgbm90IHNldApDT05GSUdf
SU5FVD15CkNPTkZJR19JUF9NVUxUSUNBU1Q9eQojIENPTkZJR19JUF9BRFZBTkNFRF9ST1VURVIg
aXMgbm90IHNldApDT05GSUdfSVBfRklCX0hBU0g9eQpDT05GSUdfSVBfUE5QPXkKQ09ORklHX0lQ
X1BOUF9ESENQPXkKQ09ORklHX0lQX1BOUF9CT09UUD15CiMgQ09ORklHX0lQX1BOUF9SQVJQIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX0lQSVAgaXMgbm90IHNldAojIENPTkZJR19ORVRfSVBHUkUg
aXMgbm90IHNldAojIENPTkZJR19JUF9NUk9VVEUgaXMgbm90IHNldApDT05GSUdfU1lOX0NPT0tJ
RVM9eQojIENPTkZJR19JTkVUX0FIIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9FU1AgaXMgbm90
IHNldAojIENPTkZJR19JTkVUX0lQQ09NUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVRfWEZSTV9U
VU5ORUwgaXMgbm90IHNldApDT05GSUdfSU5FVF9UVU5ORUw9eQpDT05GSUdfSU5FVF9YRlJNX01P
REVfVFJBTlNQT1JUPXkKQ09ORklHX0lORVRfWEZSTV9NT0RFX1RVTk5FTD15CkNPTkZJR19JTkVU
X1hGUk1fTU9ERV9CRUVUPXkKIyBDT05GSUdfSU5FVF9MUk8gaXMgbm90IHNldApDT05GSUdfSU5F
VF9ESUFHPXkKQ09ORklHX0lORVRfVENQX0RJQUc9eQojIENPTkZJR19UQ1BfQ09OR19BRFZBTkNF
RCBpcyBub3Qgc2V0CkNPTkZJR19UQ1BfQ09OR19DVUJJQz15CkNPTkZJR19ERUZBVUxUX1RDUF9D
T05HPSJjdWJpYyIKQ09ORklHX0lQVjY9eQojIENPTkZJR19JUFY2X1BSSVZBQ1kgaXMgbm90IHNl
dAojIENPTkZJR19JUFY2X1JPVVRFUl9QUkVGIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVDZfQUgg
aXMgbm90IHNldAojIENPTkZJR19JTkVUNl9FU1AgaXMgbm90IHNldAojIENPTkZJR19JTkVUNl9J
UENPTVAgaXMgbm90IHNldAojIENPTkZJR19JTkVUNl9YRlJNX1RVTk5FTCBpcyBub3Qgc2V0CiMg
Q09ORklHX0lORVQ2X1RVTk5FTCBpcyBub3Qgc2V0CkNPTkZJR19JTkVUNl9YRlJNX01PREVfVFJB
TlNQT1JUPXkKQ09ORklHX0lORVQ2X1hGUk1fTU9ERV9UVU5ORUw9eQpDT05GSUdfSU5FVDZfWEZS
TV9NT0RFX0JFRVQ9eQpDT05GSUdfSVBWNl9TSVQ9eQpDT05GSUdfSVBWNl9ORElTQ19OT0RFVFlQ
RT15CiMgQ09ORklHX0lQVjZfVFVOTkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUV09SS19TRUNN
QVJLIGlzIG5vdCBzZXQKQ09ORklHX05FVEZJTFRFUj15CiMgQ09ORklHX05FVEZJTFRFUl9ERUJV
RyBpcyBub3Qgc2V0CkNPTkZJR19ORVRGSUxURVJfQURWQU5DRUQ9eQoKIwojIENvcmUgTmV0Zmls
dGVyIENvbmZpZ3VyYXRpb24KIwojIENPTkZJR19ORVRGSUxURVJfTkVUTElOS19RVUVVRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9ORVRMSU5LX0xPRyBpcyBub3Qgc2V0CiMgQ09ORklH
X05GX0NPTk5UUkFDSyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVEFCTEVTIGlzIG5v
dCBzZXQKIyBDT05GSUdfSVBfVlMgaXMgbm90IHNldAoKIwojIElQOiBOZXRmaWx0ZXIgQ29uZmln
dXJhdGlvbgojCiMgQ09ORklHX05GX0RFRlJBR19JUFY0IGlzIG5vdCBzZXQKIyBDT05GSUdfSVBf
TkZfUVVFVUUgaXMgbm90IHNldAojIENPTkZJR19JUF9ORl9JUFRBQkxFUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0lQX05GX0FSUFRBQkxFUyBpcyBub3Qgc2V0CgojCiMgSVB2NjogTmV0ZmlsdGVyIENv
bmZpZ3VyYXRpb24KIwojIENPTkZJR19JUDZfTkZfUVVFVUUgaXMgbm90IHNldAojIENPTkZJR19J
UDZfTkZfSVBUQUJMRVMgaXMgbm90IHNldAojIENPTkZJR19BVE0gaXMgbm90IHNldAojIENPTkZJ
R19CUklER0UgaXMgbm90IHNldAojIENPTkZJR19WTEFOXzgwMjFRIGlzIG5vdCBzZXQKIyBDT05G
SUdfREVDTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfTExDMiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQ
WCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUQUxLIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhPTkVUIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSEVEIGlzIG5vdCBzZXQKIyBDT05GSUdfRENCIGlzIG5v
dCBzZXQKCiMKIyBOZXR3b3JrIHRlc3RpbmcKIwojIENPTkZJR19ORVRfUEtUR0VOIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSEFNUkFESU8gaXMgbm90IHNldAojIENPTkZJR19DQU4gaXMgbm90IHNldAoj
IENPTkZJR19JUkRBIGlzIG5vdCBzZXQKIyBDT05GSUdfQlQgaXMgbm90IHNldAojIENPTkZJR19X
SVJFTEVTUyBpcyBub3Qgc2V0CiMgQ09ORklHX1dJTUFYIGlzIG5vdCBzZXQKIyBDT05GSUdfUkZL
SUxMIGlzIG5vdCBzZXQKCiMKIyBEZXZpY2UgRHJpdmVycwojCgojCiMgR2VuZXJpYyBEcml2ZXIg
T3B0aW9ucwojCkNPTkZJR19VRVZFTlRfSEVMUEVSX1BBVEg9Ii9zYmluL2hvdHBsdWciCkNPTkZJ
R19TVEFOREFMT05FPXkKQ09ORklHX1BSRVZFTlRfRklSTVdBUkVfQlVJTEQ9eQojIENPTkZJR19G
V19MT0FERVIgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19EUklWRVIgaXMgbm90IHNldAojIENP
TkZJR19ERUJVR19ERVZSRVMgaXMgbm90IHNldAojIENPTkZJR19TWVNfSFlQRVJWSVNPUiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NPTk5FQ1RPUiBpcyBub3Qgc2V0CkNPTkZJR19NVEQ9eQojIENPTkZJ
R19NVERfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19NVERfQ09OQ0FUIGlzIG5vdCBzZXQKQ09O
RklHX01URF9QQVJUSVRJT05TPXkKIyBDT05GSUdfTVREX1JFREJPT1RfUEFSVFMgaXMgbm90IHNl
dAojIENPTkZJR19NVERfQ01ETElORV9QQVJUUyBpcyBub3Qgc2V0CkNPTkZJR19NVERfT0ZfUEFS
VFM9eQojIENPTkZJR19NVERfQVI3X1BBUlRTIGlzIG5vdCBzZXQKCiMKIyBVc2VyIE1vZHVsZXMg
QW5kIFRyYW5zbGF0aW9uIExheWVycwojCkNPTkZJR19NVERfQ0hBUj15CkNPTkZJR19NVERfQkxL
REVWUz15CkNPTkZJR19NVERfQkxPQ0s9eQojIENPTkZJR19GVEwgaXMgbm90IHNldAojIENPTkZJ
R19ORlRMIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5GVEwgaXMgbm90IHNldAojIENPTkZJR19SRkRf
RlRMIGlzIG5vdCBzZXQKIyBDT05GSUdfU1NGREMgaXMgbm90IHNldAojIENPTkZJR19NVERfT09Q
UyBpcyBub3Qgc2V0CgojCiMgUkFNL1JPTS9GbGFzaCBjaGlwIGRyaXZlcnMKIwojIENPTkZJR19N
VERfQ0ZJIGlzIG5vdCBzZXQKQ09ORklHX01URF9KRURFQ1BST0JFPXkKQ09ORklHX01URF9HRU5f
UFJPQkU9eQpDT05GSUdfTVREX0NGSV9BRFZfT1BUSU9OUz15CkNPTkZJR19NVERfQ0ZJX05PU1dB
UD15CiMgQ09ORklHX01URF9DRklfQkVfQllURV9TV0FQIGlzIG5vdCBzZXQKIyBDT05GSUdfTVRE
X0NGSV9MRV9CWVRFX1NXQVAgaXMgbm90IHNldApDT05GSUdfTVREX0NGSV9HRU9NRVRSWT15CiMg
Q09ORklHX01URF9NQVBfQkFOS19XSURUSF8xIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX01BUF9C
QU5LX1dJRFRIXzIgaXMgbm90IHNldApDT05GSUdfTVREX01BUF9CQU5LX1dJRFRIXzQ9eQojIENP
TkZJR19NVERfTUFQX0JBTktfV0lEVEhfOCBpcyBub3Qgc2V0CiMgQ09ORklHX01URF9NQVBfQkFO
S19XSURUSF8xNiBpcyBub3Qgc2V0CiMgQ09ORklHX01URF9NQVBfQkFOS19XSURUSF8zMiBpcyBu
b3Qgc2V0CiMgQ09ORklHX01URF9DRklfSTEgaXMgbm90IHNldAojIENPTkZJR19NVERfQ0ZJX0ky
IGlzIG5vdCBzZXQKQ09ORklHX01URF9DRklfSTQ9eQojIENPTkZJR19NVERfQ0ZJX0k4IGlzIG5v
dCBzZXQKIyBDT05GSUdfTVREX09UUCBpcyBub3Qgc2V0CkNPTkZJR19NVERfQ0ZJX0lOVEVMRVhU
PXkKIyBDT05GSUdfTVREX0NGSV9BTURTVEQgaXMgbm90IHNldAojIENPTkZJR19NVERfQ0ZJX1NU
QUEgaXMgbm90IHNldApDT05GSUdfTVREX0NGSV9VVElMPXkKIyBDT05GSUdfTVREX1JBTSBpcyBu
b3Qgc2V0CiMgQ09ORklHX01URF9ST00gaXMgbm90IHNldAojIENPTkZJR19NVERfQUJTRU5UIGlz
IG5vdCBzZXQKCiMKIyBNYXBwaW5nIGRyaXZlcnMgZm9yIGNoaXAgYWNjZXNzCiMKIyBDT05GSUdf
TVREX0NPTVBMRVhfTUFQUElOR1MgaXMgbm90IHNldAojIENPTkZJR19NVERfUEhZU01BUCBpcyBu
b3Qgc2V0CkNPTkZJR19NVERfUEhZU01BUF9PRj15CiMgQ09ORklHX01URF9TQkM4MjQwIGlzIG5v
dCBzZXQKIyBDT05GSUdfTVREX1BMQVRSQU0gaXMgbm90IHNldAoKIwojIFNlbGYtY29udGFpbmVk
IE1URCBkZXZpY2UgZHJpdmVycwojCiMgQ09ORklHX01URF9TTFJBTSBpcyBub3Qgc2V0CiMgQ09O
RklHX01URF9QSFJBTSBpcyBub3Qgc2V0CiMgQ09ORklHX01URF9NVERSQU0gaXMgbm90IHNldAoj
IENPTkZJR19NVERfQkxPQ0syTVREIGlzIG5vdCBzZXQKCiMKIyBEaXNrLU9uLUNoaXAgRGV2aWNl
IERyaXZlcnMKIwojIENPTkZJR19NVERfRE9DMjAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX01URF9E
T0MyMDAxIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX0RPQzIwMDFQTFVTIGlzIG5vdCBzZXQKIyBD
T05GSUdfTVREX05BTkQgaXMgbm90IHNldAojIENPTkZJR19NVERfT05FTkFORCBpcyBub3Qgc2V0
CgojCiMgTFBERFIgZmxhc2ggbWVtb3J5IGRyaXZlcnMKIwojIENPTkZJR19NVERfTFBERFIgaXMg
bm90IHNldAoKIwojIFVCSSAtIFVuc29ydGVkIGJsb2NrIGltYWdlcwojCiMgQ09ORklHX01URF9V
QkkgaXMgbm90IHNldApDT05GSUdfT0ZfREVWSUNFPXkKQ09ORklHX09GX0dQSU89eQojIENPTkZJ
R19QQVJQT1JUIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVY9eQojIENPTkZJR19CTEtfREVWX0ZE
IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9DT1dfQ09NTU9OIGlzIG5vdCBzZXQKQ09ORklH
X0JMS19ERVZfTE9PUD15CiMgQ09ORklHX0JMS19ERVZfQ1JZUFRPTE9PUCBpcyBub3Qgc2V0CiMg
Q09ORklHX0JMS19ERVZfTkJEIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfUkFNPXkKQ09ORklH
X0JMS19ERVZfUkFNX0NPVU5UPTE2CkNPTkZJR19CTEtfREVWX1JBTV9TSVpFPTQwOTYKIyBDT05G
SUdfQkxLX0RFVl9YSVAgaXMgbm90IHNldAojIENPTkZJR19DRFJPTV9QS1RDRFZEIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQVRBX09WRVJfRVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9IRCBp
cyBub3Qgc2V0CkNPTkZJR19NSVNDX0RFVklDRVM9eQojIENPTkZJR19FTkNMT1NVUkVfU0VSVklD
RVMgaXMgbm90IHNldAoKIwojIEVFUFJPTSBzdXBwb3J0CiMKIyBDT05GSUdfRUVQUk9NXzkzQ1g2
IGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfSURFPXkKQ09ORklHX0lERT15CgojCiMgUGxlYXNlIHNl
ZSBEb2N1bWVudGF0aW9uL2lkZS9pZGUudHh0IGZvciBoZWxwL2luZm8gb24gSURFIGRyaXZlcwoj
CiMgQ09ORklHX0JMS19ERVZfSURFX1NBVEEgaXMgbm90IHNldApDT05GSUdfSURFX0dEPXkKQ09O
RklHX0lERV9HRF9BVEE9eQojIENPTkZJR19JREVfR0RfQVRBUEkgaXMgbm90IHNldAojIENPTkZJ
R19CTEtfREVWX0lERUNEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JREVUQVBFIGlzIG5v
dCBzZXQKIyBDT05GSUdfSURFX1RBU0tfSU9DVEwgaXMgbm90IHNldApDT05GSUdfSURFX1BST0Nf
RlM9eQoKIwojIElERSBjaGlwc2V0IHN1cHBvcnQvYnVnZml4ZXMKIwojIENPTkZJR19CTEtfREVW
X1BMQVRGT1JNIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JREVETUEgaXMgbm90IHNldAoK
IwojIFNDU0kgZGV2aWNlIHN1cHBvcnQKIwojIENPTkZJR19SQUlEX0FUVFJTIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0NTSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRE1BIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9ORVRMSU5LIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRBIGlzIG5vdCBzZXQKIyBD
T05GSUdfTUQgaXMgbm90IHNldAojIENPTkZJR19NQUNJTlRPU0hfRFJJVkVSUyBpcyBub3Qgc2V0
CkNPTkZJR19ORVRERVZJQ0VTPXkKQ09ORklHX0NPTVBBVF9ORVRfREVWX09QUz15CiMgQ09ORklH
X0RVTU1ZIGlzIG5vdCBzZXQKIyBDT05GSUdfQk9ORElORyBpcyBub3Qgc2V0CiMgQ09ORklHX0VR
VUFMSVpFUiBpcyBub3Qgc2V0CkNPTkZJR19UVU49eQojIENPTkZJR19WRVRIIGlzIG5vdCBzZXQK
Q09ORklHX1BIWUxJQj15CgojCiMgTUlJIFBIWSBkZXZpY2UgZHJpdmVycwojCiMgQ09ORklHX01B
UlZFTExfUEhZIGlzIG5vdCBzZXQKQ09ORklHX0RBVklDT01fUEhZPXkKIyBDT05GSUdfUVNFTUlf
UEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfTFhUX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0NJQ0FE
QV9QSFkgaXMgbm90IHNldAojIENPTkZJR19WSVRFU1NFX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NNU0NfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfQlJPQURDT01fUEhZIGlzIG5vdCBzZXQKIyBD
T05GSUdfSUNQTFVTX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX1JFQUxURUtfUEhZIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkFUSU9OQUxfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfU1RFMTBYUCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0xTSV9FVDEwMTFDX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZJWEVE
X1BIWSBpcyBub3Qgc2V0CkNPTkZJR19NRElPX0JJVEJBTkc9eQojIENPTkZJR19NRElPX0dQSU8g
aXMgbm90IHNldApDT05GSUdfTkVUX0VUSEVSTkVUPXkKQ09ORklHX01JST15CiMgQ09ORklHX0VU
SE9DIGlzIG5vdCBzZXQKIyBDT05GSUdfRE5FVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lCTV9ORVdf
RU1BQ19aTUlJIGlzIG5vdCBzZXQKIyBDT05GSUdfSUJNX05FV19FTUFDX1JHTUlJIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSUJNX05FV19FTUFDX1RBSCBpcyBub3Qgc2V0CiMgQ09ORklHX0lCTV9ORVdf
RU1BQ19FTUFDNCBpcyBub3Qgc2V0CiMgQ09ORklHX0lCTV9ORVdfRU1BQ19OT19GTE9XX0NUUkwg
aXMgbm90IHNldAojIENPTkZJR19JQk1fTkVXX0VNQUNfTUFMX0NMUl9JQ0lOVFNUQVQgaXMgbm90
IHNldAojIENPTkZJR19JQk1fTkVXX0VNQUNfTUFMX0NPTU1PTl9FUlIgaXMgbm90IHNldAojIENP
TkZJR19CNDQgaXMgbm90IHNldApDT05GSUdfRlNfRU5FVD15CiMgQ09ORklHX0ZTX0VORVRfSEFT
X1NDQyBpcyBub3Qgc2V0CkNPTkZJR19GU19FTkVUX0hBU19GQ0M9eQpDT05GSUdfRlNfRU5FVF9N
RElPX0ZDQz15CkNPTkZJR19ORVRERVZfMTAwMD15CiMgQ09ORklHX0ZTTF9QUV9NRElPIGlzIG5v
dCBzZXQKIyBDT05GSUdfR0lBTkZBUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VDQ19HRVRIIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVUREVWXzEwMDAwIGlzIG5vdCBzZXQKCiMKIyBXaXJlbGVzcyBMQU4K
IwojIENPTkZJR19XTEFOX1BSRTgwMjExIGlzIG5vdCBzZXQKIyBDT05GSUdfV0xBTl84MDIxMSBp
cyBub3Qgc2V0CgojCiMgRW5hYmxlIFdpTUFYIChOZXR3b3JraW5nIG9wdGlvbnMpIHRvIHNlZSB0
aGUgV2lNQVggZHJpdmVycwojCiMgQ09ORklHX1dBTiBpcyBub3Qgc2V0CkNPTkZJR19QUFA9eQoj
IENPTkZJR19QUFBfRklMVEVSIGlzIG5vdCBzZXQKQ09ORklHX1BQUF9BU1lOQz15CkNPTkZJR19Q
UFBfU1lOQ19UVFk9eQpDT05GSUdfUFBQX0RFRkxBVEU9eQojIENPTkZJR19QUFBfQlNEQ09NUCBp
cyBub3Qgc2V0CiMgQ09ORklHX1NMSVAgaXMgbm90IHNldApDT05GSUdfU0xIQz15CiMgQ09ORklH
X05FVFBPTEwgaXMgbm90IHNldAojIENPTkZJR19ORVRfUE9MTF9DT05UUk9MTEVSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSVNETiBpcyBub3Qgc2V0CiMgQ09ORklHX1BIT05FIGlzIG5vdCBzZXQKCiMK
IyBJbnB1dCBkZXZpY2Ugc3VwcG9ydAojCkNPTkZJR19JTlBVVD15CiMgQ09ORklHX0lOUFVUX0ZG
X01FTUxFU1MgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9QT0xMREVWIGlzIG5vdCBzZXQKCiMK
IyBVc2VybGFuZCBpbnRlcmZhY2VzCiMKIyBDT05GSUdfSU5QVVRfTU9VU0VERVYgaXMgbm90IHNl
dAojIENPTkZJR19JTlBVVF9KT1lERVYgaXMgbm90IHNldApDT05GSUdfSU5QVVRfRVZERVY9eQoj
IENPTkZJR19JTlBVVF9FVkJVRyBpcyBub3Qgc2V0CgojCiMgSW5wdXQgRGV2aWNlIERyaXZlcnMK
IwojIENPTkZJR19JTlBVVF9LRVlCT0FSRCBpcyBub3Qgc2V0CkNPTkZJR19JTlBVVF9NT1VTRT15
CkNPTkZJR19NT1VTRV9QUzI9eQpDT05GSUdfTU9VU0VfUFMyX0FMUFM9eQpDT05GSUdfTU9VU0Vf
UFMyX0xPR0lQUzJQUD15CkNPTkZJR19NT1VTRV9QUzJfU1lOQVBUSUNTPXkKQ09ORklHX01PVVNF
X1BTMl9UUkFDS1BPSU5UPXkKIyBDT05GSUdfTU9VU0VfUFMyX0VMQU5URUNIIGlzIG5vdCBzZXQK
IyBDT05GSUdfTU9VU0VfUFMyX1RPVUNIS0lUIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfU0VS
SUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfVlNYWFhBQSBpcyBub3Qgc2V0CiMgQ09ORklH
X01PVVNFX0dQSU8gaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9KT1lTVElDSyBpcyBub3Qgc2V0
CiMgQ09ORklHX0lOUFVUX1RBQkxFVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX1RPVUNIU0NS
RUVOIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfTUlTQyBpcyBub3Qgc2V0CgojCiMgSGFyZHdh
cmUgSS9PIHBvcnRzCiMKQ09ORklHX1NFUklPPXkKIyBDT05GSUdfU0VSSU9fSTgwNDIgaXMgbm90
IHNldApDT05GSUdfU0VSSU9fU0VSUE9SVD15CkNPTkZJR19TRVJJT19MSUJQUzI9eQojIENPTkZJ
R19TRVJJT19SQVcgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19YSUxJTlhfWFBTX1BTMiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0dBTUVQT1JUIGlzIG5vdCBzZXQKCiMKIyBDaGFyYWN0ZXIgZGV2aWNl
cwojCiMgQ09ORklHX1ZUIGlzIG5vdCBzZXQKQ09ORklHX0RFVktNRU09eQojIENPTkZJR19TRVJJ
QUxfTk9OU1RBTkRBUkQgaXMgbm90IHNldAoKIwojIFNlcmlhbCBkcml2ZXJzCiMKIyBDT05GSUdf
U0VSSUFMXzgyNTAgaXMgbm90IHNldAoKIwojIE5vbi04MjUwIHNlcmlhbCBwb3J0IHN1cHBvcnQK
IwojIENPTkZJR19TRVJJQUxfVUFSVExJVEUgaXMgbm90IHNldApDT05GSUdfU0VSSUFMX0NPUkU9
eQpDT05GSUdfU0VSSUFMX0NPUkVfQ09OU09MRT15CkNPTkZJR19TRVJJQUxfQ1BNPXkKQ09ORklH
X1NFUklBTF9DUE1fQ09OU09MRT15CiMgQ09ORklHX1NFUklBTF9RRSBpcyBub3Qgc2V0CkNPTkZJ
R19VTklYOThfUFRZUz15CiMgQ09ORklHX0RFVlBUU19NVUxUSVBMRV9JTlNUQU5DRVMgaXMgbm90
IHNldApDT05GSUdfTEVHQUNZX1BUWVM9eQpDT05GSUdfTEVHQUNZX1BUWV9DT1VOVD0yNTYKIyBD
T05GSUdfSVBNSV9IQU5ETEVSIGlzIG5vdCBzZXQKQ09ORklHX0hXX1JBTkRPTT15CiMgQ09ORklH
X0hXX1JBTkRPTV9USU1FUklPTUVNIGlzIG5vdCBzZXQKIyBDT05GSUdfTlZSQU0gaXMgbm90IHNl
dAojIENPTkZJR19HRU5fUlRDIGlzIG5vdCBzZXQKIyBDT05GSUdfUjM5NjQgaXMgbm90IHNldApD
T05GSUdfUkFXX0RSSVZFUj15CkNPTkZJR19NQVhfUkFXX0RFVlM9MjU2CiMgQ09ORklHX0kyQyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NQSSBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX1dBTlRfT1BUSU9O
QUxfR1BJT0xJQj15CkNPTkZJR19BUkNIX1JFUVVJUkVfR1BJT0xJQj15CkNPTkZJR19HUElPTElC
PXkKIyBDT05GSUdfREVCVUdfR1BJTyBpcyBub3Qgc2V0CgojCiMgTWVtb3J5IG1hcHBlZCBHUElP
IGV4cGFuZGVyczoKIwojIENPTkZJR19HUElPX1hJTElOWCBpcyBub3Qgc2V0CgojCiMgSTJDIEdQ
SU8gZXhwYW5kZXJzOgojCgojCiMgUENJIEdQSU8gZXhwYW5kZXJzOgojCgojCiMgU1BJIEdQSU8g
ZXhwYW5kZXJzOgojCiMgQ09ORklHX1cxIGlzIG5vdCBzZXQKIyBDT05GSUdfUE9XRVJfU1VQUExZ
IGlzIG5vdCBzZXQKIyBDT05GSUdfSFdNT04gaXMgbm90IHNldAojIENPTkZJR19USEVSTUFMIGlz
IG5vdCBzZXQKIyBDT05GSUdfVEhFUk1BTF9IV01PTiBpcyBub3Qgc2V0CiMgQ09ORklHX1dBVENI
RE9HIGlzIG5vdCBzZXQKQ09ORklHX1NTQl9QT1NTSUJMRT15CgojCiMgU29uaWNzIFNpbGljb24g
QmFja3BsYW5lCiMKIyBDT05GSUdfU1NCIGlzIG5vdCBzZXQKCiMKIyBNdWx0aWZ1bmN0aW9uIGRl
dmljZSBkcml2ZXJzCiMKIyBDT05GSUdfTUZEX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19NRkRf
U001MDEgaXMgbm90IHNldAojIENPTkZJR19IVENfUEFTSUMzIGlzIG5vdCBzZXQKIyBDT05GSUdf
TUZEX1RNSU8gaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFUT1IgaXMgbm90IHNldAoKIwojIE11
bHRpbWVkaWEgZGV2aWNlcwojCgojCiMgTXVsdGltZWRpYSBjb3JlIHN1cHBvcnQKIwojIENPTkZJ
R19WSURFT19ERVYgaXMgbm90IHNldAojIENPTkZJR19EVkJfQ09SRSBpcyBub3Qgc2V0CiMgQ09O
RklHX1ZJREVPX01FRElBIGlzIG5vdCBzZXQKCiMKIyBNdWx0aW1lZGlhIGRyaXZlcnMKIwpDT05G
SUdfREFCPXkKCiMKIyBHcmFwaGljcyBzdXBwb3J0CiMKIyBDT05GSUdfVkdBU1RBVEUgaXMgbm90
IHNldAojIENPTkZJR19WSURFT19PVVRQVVRfQ09OVFJPTCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZC
IGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0xDRF9TVVBQT1JUIGlzIG5vdCBzZXQKCiMK
IyBEaXNwbGF5IGRldmljZSBzdXBwb3J0CiMKIyBDT05GSUdfRElTUExBWV9TVVBQT1JUIGlzIG5v
dCBzZXQKIyBDT05GSUdfU09VTkQgaXMgbm90IHNldAojIENPTkZJR19ISURfU1VQUE9SVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9TVVBQT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfTU1DIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUVNU1RJQ0sgaXMgbm90IHNldAojIENPTkZJR19ORVdfTEVEUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FDQ0VTU0lCSUxJVFkgaXMgbm90IHNldAojIENPTkZJR19FREFDIGlz
IG5vdCBzZXQKIyBDT05GSUdfUlRDX0NMQVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1BREVWSUNF
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0FVWERJU1BMQVkgaXMgbm90IHNldAojIENPTkZJR19VSU8g
aXMgbm90IHNldAojIENPTkZJR19TVEFHSU5HIGlzIG5vdCBzZXQKCiMKIyBGaWxlIHN5c3RlbXMK
IwpDT05GSUdfRVhUMl9GUz15CiMgQ09ORklHX0VYVDJfRlNfWEFUVFIgaXMgbm90IHNldAojIENP
TkZJR19FWFQyX0ZTX1hJUCBpcyBub3Qgc2V0CkNPTkZJR19FWFQzX0ZTPXkKIyBDT05GSUdfRVhU
M19ERUZBVUxUU19UT19PUkRFUkVEIGlzIG5vdCBzZXQKQ09ORklHX0VYVDNfRlNfWEFUVFI9eQoj
IENPTkZJR19FWFQzX0ZTX1BPU0lYX0FDTCBpcyBub3Qgc2V0CiMgQ09ORklHX0VYVDNfRlNfU0VD
VVJJVFkgaXMgbm90IHNldAojIENPTkZJR19FWFQ0X0ZTIGlzIG5vdCBzZXQKQ09ORklHX0pCRD15
CkNPTkZJR19GU19NQkNBQ0hFPXkKIyBDT05GSUdfUkVJU0VSRlNfRlMgaXMgbm90IHNldAojIENP
TkZJR19KRlNfRlMgaXMgbm90IHNldApDT05GSUdfRlNfUE9TSVhfQUNMPXkKQ09ORklHX0ZJTEVf
TE9DS0lORz15CiMgQ09ORklHX1hGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX09DRlMyX0ZTIGlz
IG5vdCBzZXQKQ09ORklHX0ROT1RJRlk9eQpDT05GSUdfSU5PVElGWT15CkNPTkZJR19JTk9USUZZ
X1VTRVI9eQojIENPTkZJR19RVU9UQSBpcyBub3Qgc2V0CiMgQ09ORklHX0FVVE9GU19GUyBpcyBu
b3Qgc2V0CkNPTkZJR19BVVRPRlM0X0ZTPXkKIyBDT05GSUdfRlVTRV9GUyBpcyBub3Qgc2V0Cgoj
CiMgQ2FjaGVzCiMKCiMKIyBDRC1ST00vRFZEIEZpbGVzeXN0ZW1zCiMKIyBDT05GSUdfSVNPOTY2
MF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1VERl9GUyBpcyBub3Qgc2V0CgojCiMgRE9TL0ZBVC9O
VCBGaWxlc3lzdGVtcwojCiMgQ09ORklHX01TRE9TX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfVkZB
VF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX05URlNfRlMgaXMgbm90IHNldAoKIwojIFBzZXVkbyBm
aWxlc3lzdGVtcwojCkNPTkZJR19QUk9DX0ZTPXkKQ09ORklHX1BST0NfS0NPUkU9eQpDT05GSUdf
UFJPQ19TWVNDVEw9eQpDT05GSUdfUFJPQ19QQUdFX01PTklUT1I9eQpDT05GSUdfU1lTRlM9eQpD
T05GSUdfVE1QRlM9eQojIENPTkZJR19UTVBGU19QT1NJWF9BQ0wgaXMgbm90IHNldAojIENPTkZJ
R19IVUdFVExCX1BBR0UgaXMgbm90IHNldAojIENPTkZJR19DT05GSUdGU19GUyBpcyBub3Qgc2V0
CkNPTkZJR19NSVNDX0ZJTEVTWVNURU1TPXkKIyBDT05GSUdfSEZTUExVU19GUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0pGRlMyX0ZTIGlzIG5vdCBzZXQKQ09ORklHX0NSQU1GUz15CiMgQ09ORklHX1NR
VUFTSEZTIGlzIG5vdCBzZXQKIyBDT05GSUdfVlhGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX01J
TklYX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfT01GU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hQ
RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19RTlg0RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19S
T01GU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NZU1ZfRlMgaXMgbm90IHNldAojIENPTkZJR19V
RlNfRlMgaXMgbm90IHNldApDT05GSUdfTkVUV09SS19GSUxFU1lTVEVNUz15CkNPTkZJR19ORlNf
RlM9eQpDT05GSUdfTkZTX1YzPXkKQ09ORklHX05GU19WM19BQ0w9eQpDT05GSUdfUk9PVF9ORlM9
eQojIENPTkZJR19ORlNEIGlzIG5vdCBzZXQKQ09ORklHX0xPQ0tEPXkKQ09ORklHX0xPQ0tEX1Y0
PXkKQ09ORklHX05GU19BQ0xfU1VQUE9SVD15CkNPTkZJR19ORlNfQ09NTU9OPXkKQ09ORklHX1NV
TlJQQz15CiMgQ09ORklHX1NNQl9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NJRlMgaXMgbm90IHNl
dAojIENPTkZJR19OQ1BfRlMgaXMgbm90IHNldAojIENPTkZJR19DT0RBX0ZTIGlzIG5vdCBzZXQK
CiMKIyBQYXJ0aXRpb24gVHlwZXMKIwpDT05GSUdfUEFSVElUSU9OX0FEVkFOQ0VEPXkKIyBDT05G
SUdfQUNPUk5fUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfT1NGX1BBUlRJVElPTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FNSUdBX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0FUQVJJ
X1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX01BQ19QQVJUSVRJT04gaXMgbm90IHNldAoj
IENPTkZJR19NU0RPU19QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19MRE1fUEFSVElUSU9O
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0dJX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX1VM
VFJJWF9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19TVU5fUEFSVElUSU9OIGlzIG5vdCBz
ZXQKIyBDT05GSUdfS0FSTUFfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfRUZJX1BBUlRJ
VElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX1NZU1Y2OF9QQVJUSVRJT04gaXMgbm90IHNldApDT05G
SUdfTkxTPXkKQ09ORklHX05MU19ERUZBVUxUPSJpc284ODU5LTEiCkNPTkZJR19OTFNfQ09ERVBB
R0VfNDM3PXkKIyBDT05GSUdfTkxTX0NPREVQQUdFXzczNyBpcyBub3Qgc2V0CiMgQ09ORklHX05M
U19DT0RFUEFHRV83NzUgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODUwIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1MiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19D
T0RFUEFHRV84NTUgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODU3IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RF
UEFHRV84NjEgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYyIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFH
RV84NjQgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY1IGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0NPREVQQUdFXzg2NiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84
NjkgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTM2IGlzIG5vdCBzZXQKIyBDT05G
SUdfTkxTX0NPREVQQUdFXzk1MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85MzIg
aXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTQ5IGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0NPREVQQUdFXzg3NCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzggaXMgbm90
IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfMTI1MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19D
T0RFUEFHRV8xMjUxIGlzIG5vdCBzZXQKQ09ORklHX05MU19BU0NJST15CkNPTkZJR19OTFNfSVNP
ODg1OV8xPXkKIyBDT05GSUdfTkxTX0lTTzg4NTlfMiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19J
U084ODU5XzMgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV80IGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0lTTzg4NTlfNSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzYgaXMg
bm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV83IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lT
Tzg4NTlfOSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzEzIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0lTTzg4NTlfMTQgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8xNSBp
cyBub3Qgc2V0CiMgQ09ORklHX05MU19LT0k4X1IgaXMgbm90IHNldAojIENPTkZJR19OTFNfS09J
OF9VIGlzIG5vdCBzZXQKQ09ORklHX05MU19VVEY4PXkKIyBDT05GSUdfQklOQVJZX1BSSU5URiBp
cyBub3Qgc2V0CgojCiMgTGlicmFyeSByb3V0aW5lcwojCkNPTkZJR19CSVRSRVZFUlNFPXkKQ09O
RklHX0dFTkVSSUNfRklORF9MQVNUX0JJVD15CkNPTkZJR19DUkNfQ0NJVFQ9eQojIENPTkZJR19D
UkMxNiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQ19UMTBESUYgaXMgbm90IHNldAojIENPTkZJR19D
UkNfSVRVX1QgaXMgbm90IHNldApDT05GSUdfQ1JDMzI9eQojIENPTkZJR19DUkM3IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTElCQ1JDMzJDIGlzIG5vdCBzZXQKQ09ORklHX1pMSUJfSU5GTEFURT15CkNP
TkZJR19aTElCX0RFRkxBVEU9eQpDT05GSUdfREVDT01QUkVTU19HWklQPXkKQ09ORklHX0hBU19J
T01FTT15CkNPTkZJR19IQVNfSU9QT1JUPXkKQ09ORklHX0hBU19ETUE9eQpDT05GSUdfSEFWRV9M
TUI9eQpDT05GSUdfTkxBVFRSPXkKCiMKIyBLZXJuZWwgaGFja2luZwojCiMgQ09ORklHX1BSSU5U
S19USU1FIGlzIG5vdCBzZXQKQ09ORklHX0VOQUJMRV9XQVJOX0RFUFJFQ0FURUQ9eQpDT05GSUdf
RU5BQkxFX01VU1RfQ0hFQ0s9eQpDT05GSUdfRlJBTUVfV0FSTj0xMDI0CkNPTkZJR19NQUdJQ19T
WVNSUT15CiMgQ09ORklHX1VOVVNFRF9TWU1CT0xTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdf
RlMgaXMgbm90IHNldAojIENPTkZJR19IRUFERVJTX0NIRUNLIGlzIG5vdCBzZXQKQ09ORklHX0RF
QlVHX0tFUk5FTD15CiMgQ09ORklHX0RFQlVHX1NISVJRIGlzIG5vdCBzZXQKQ09ORklHX0RFVEVD
VF9TT0ZUTE9DS1VQPXkKIyBDT05GSUdfQk9PVFBBUkFNX1NPRlRMT0NLVVBfUEFOSUMgaXMgbm90
IHNldApDT05GSUdfQk9PVFBBUkFNX1NPRlRMT0NLVVBfUEFOSUNfVkFMVUU9MApDT05GSUdfREVU
RUNUX0hVTkdfVEFTSz15CiMgQ09ORklHX0JPT1RQQVJBTV9IVU5HX1RBU0tfUEFOSUMgaXMgbm90
IHNldApDT05GSUdfQk9PVFBBUkFNX0hVTkdfVEFTS19QQU5JQ19WQUxVRT0wCiMgQ09ORklHX1ND
SEVEX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NIRURTVEFUUyBpcyBub3Qgc2V0CiMgQ09O
RklHX1RJTUVSX1NUQVRTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfT0JKRUNUUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1NMVUJfREVCVUdfT04gaXMgbm90IHNldAojIENPTkZJR19TTFVCX1NUQVRT
IGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfUlRfTVVURVhFUyBpcyBub3Qgc2V0CiMgQ09ORklH
X1JUX01VVEVYX1RFU1RFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NQSU5MT0NLIGlzIG5v
dCBzZXQKIyBDT05GSUdfREVCVUdfTVVURVhFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NQ
SU5MT0NLX1NMRUVQIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfTE9DS0lOR19BUElfU0VMRlRF
U1RTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfS09CSkVDVCBpcyBub3Qgc2V0CkNPTkZJR19E
RUJVR19CVUdWRVJCT1NFPXkKQ09ORklHX0RFQlVHX0lORk89eQojIENPTkZJR19ERUJVR19WTSBp
cyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1dSSVRFQ09VTlQgaXMgbm90IHNldAojIENPTkZJR19E
RUJVR19NRU1PUllfSU5JVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0xJU1QgaXMgbm90IHNl
dAojIENPTkZJR19ERUJVR19TRyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX05PVElGSUVSUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0JPT1RfUFJJTlRLX0RFTEFZIGlzIG5vdCBzZXQKIyBDT05GSUdf
UkNVX1RPUlRVUkVfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1JDVV9DUFVfU1RBTExfREVURUNU
T1IgaXMgbm90IHNldAojIENPTkZJR19CQUNLVFJBQ0VfU0VMRl9URVNUIGlzIG5vdCBzZXQKIyBD
T05GSUdfREVCVUdfQkxPQ0tfRVhUX0RFVlQgaXMgbm90IHNldAojIENPTkZJR19GQVVMVF9JTkpF
Q1RJT04gaXMgbm90IHNldAojIENPTkZJR19MQVRFTkNZVE9QIGlzIG5vdCBzZXQKQ09ORklHX1NZ
U0NUTF9TWVNDQUxMX0NIRUNLPXkKIyBDT05GSUdfREVCVUdfUEFHRUFMTE9DIGlzIG5vdCBzZXQK
Q09ORklHX0hBVkVfRlVOQ1RJT05fVFJBQ0VSPXkKQ09ORklHX0hBVkVfRlVOQ1RJT05fR1JBUEhf
VFJBQ0VSPXkKQ09ORklHX0hBVkVfRFlOQU1JQ19GVFJBQ0U9eQpDT05GSUdfSEFWRV9GVFJBQ0Vf
TUNPVU5UX1JFQ09SRD15CkNPTkZJR19UUkFDSU5HX1NVUFBPUlQ9eQoKIwojIFRyYWNlcnMKIwoj
IENPTkZJR19GVU5DVElPTl9UUkFDRVIgaXMgbm90IHNldAojIENPTkZJR19TQ0hFRF9UUkFDRVIg
aXMgbm90IHNldAojIENPTkZJR19DT05URVhUX1NXSVRDSF9UUkFDRVIgaXMgbm90IHNldAojIENP
TkZJR19FVkVOVF9UUkFDRVIgaXMgbm90IHNldAojIENPTkZJR19CT09UX1RSQUNFUiBpcyBub3Qg
c2V0CiMgQ09ORklHX1RSQUNFX0JSQU5DSF9QUk9GSUxJTkcgaXMgbm90IHNldAojIENPTkZJR19T
VEFDS19UUkFDRVIgaXMgbm90IHNldAojIENPTkZJR19LTUVNVFJBQ0UgaXMgbm90IHNldAojIENP
TkZJR19XT1JLUVVFVUVfVFJBQ0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JT19UUkFD
RSBpcyBub3Qgc2V0CiMgQ09ORklHX1NBTVBMRVMgaXMgbm90IHNldApDT05GSUdfSEFWRV9BUkNI
X0tHREI9eQpDT05GSUdfUFJJTlRfU1RBQ0tfREVQVEg9NjQKIyBDT05GSUdfREVCVUdfU1RBQ0tP
VkVSRkxPVyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NUQUNLX1VTQUdFIGlzIG5vdCBzZXQK
IyBDT05GSUdfQ09ERV9QQVRDSElOR19TRUxGVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZUUl9G
SVhVUF9TRUxGVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX01TSV9CSVRNQVBfU0VMRlRFU1QgaXMg
bm90IHNldAojIENPTkZJR19YTU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfSVJRU1RBQ0tTIGlzIG5v
dCBzZXQKQ09ORklHX0JESV9TV0lUQ0g9eQojIENPTkZJR19CT09UWF9URVhUIGlzIG5vdCBzZXQK
IyBDT05GSUdfUFBDX0VBUkxZX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBTZWN1cml0eSBvcHRpb25z
CiMKIyBDT05GSUdfS0VZUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VDVVJJVFlGUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX0ZJTEVfQ0FQ
QUJJTElUSUVTIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUTz15CgojCiMgQ3J5cHRvIGNvcmUgb3Ig
aGVscGVyCiMKIyBDT05GSUdfQ1JZUFRPX0ZJUFMgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0FM
R0FQST15CkNPTkZJR19DUllQVE9fQUxHQVBJMj15CkNPTkZJR19DUllQVE9fQUVBRDI9eQpDT05G
SUdfQ1JZUFRPX0JMS0NJUEhFUj15CkNPTkZJR19DUllQVE9fQkxLQ0lQSEVSMj15CkNPTkZJR19D
UllQVE9fSEFTSD15CkNPTkZJR19DUllQVE9fSEFTSDI9eQpDT05GSUdfQ1JZUFRPX1JORzI9eQpD
T05GSUdfQ1JZUFRPX1BDT01QPXkKQ09ORklHX0NSWVBUT19NQU5BR0VSPXkKQ09ORklHX0NSWVBU
T19NQU5BR0VSMj15CiMgQ09ORklHX0NSWVBUT19OVUxMIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBU
T19XT1JLUVVFVUU9eQojIENPTkZJR19DUllQVE9fQ1JZUFREIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1JZUFRPX0FVVEhFTkMgaXMgbm90IHNldAoKIwojIEF1dGhlbnRpY2F0ZWQgRW5jcnlwdGlvbiB3
aXRoIEFzc29jaWF0ZWQgRGF0YQojCiMgQ09ORklHX0NSWVBUT19DQ00gaXMgbm90IHNldAojIENP
TkZJR19DUllQVE9fR0NNIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NFUUlWIGlzIG5vdCBz
ZXQKCiMKIyBCbG9jayBtb2RlcwojCkNPTkZJR19DUllQVE9fQ0JDPXkKIyBDT05GSUdfQ1JZUFRP
X0NUUiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DVFMgaXMgbm90IHNldApDT05GSUdfQ1JZ
UFRPX0VDQj15CkNPTkZJR19DUllQVE9fUENCQz15CgojCiMgSGFzaCBtb2RlcwojCiMgQ09ORklH
X0NSWVBUT19ITUFDIGlzIG5vdCBzZXQKCiMKIyBEaWdlc3QKIwojIENPTkZJR19DUllQVE9fQ1JD
MzJDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX01ENCBpcyBub3Qgc2V0CkNPTkZJR19DUllQ
VE9fTUQ1PXkKIyBDT05GSUdfQ1JZUFRPX01JQ0hBRUxfTUlDIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1JZUFRPX1JNRDEyOCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19STUQxNjAgaXMgbm90IHNl
dAojIENPTkZJR19DUllQVE9fUk1EMjU2IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1JNRDMy
MCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TSEExIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZ
UFRPX1NIQTI1NiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TSEE1MTIgaXMgbm90IHNldAoj
IENPTkZJR19DUllQVE9fVEdSMTkyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1dQNTEyIGlz
IG5vdCBzZXQKCiMKIyBDaXBoZXJzCiMKIyBDT05GSUdfQ1JZUFRPX0FFUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19BTlVCSVMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQVJDNCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT19CTE9XRklTSCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBU
T19DQU1FTExJQSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DQVNUNSBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19DQVNUNiBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fREVTPXkKIyBDT05G
SUdfQ1JZUFRPX0ZDUllQVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19LSEFaQUQgaXMgbm90
IHNldAojIENPTkZJR19DUllQVE9fU0VFRCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TRVJQ
RU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1RFQSBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
WVBUT19UV09GSVNIIGlzIG5vdCBzZXQKCiMKIyBDb21wcmVzc2lvbgojCiMgQ09ORklHX0NSWVBU
T19ERUZMQVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1pMSUIgaXMgbm90IHNldAojIENP
TkZJR19DUllQVE9fTFpPIGlzIG5vdCBzZXQKCiMKIyBSYW5kb20gTnVtYmVyIEdlbmVyYXRpb24K
IwojIENPTkZJR19DUllQVE9fQU5TSV9DUFJORyBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fSFc9
eQojIENPTkZJR19DUllQVE9fREVWX1RBTElUT1MgaXMgbm90IHNldApDT05GSUdfUFBDX0NMT0NL
PXkKQ09ORklHX1BQQ19MSUJfUkhFQVA9eQojIENPTkZJR19WSVJUVUFMSVpBVElPTiBpcyBub3Qg
c2V0Cg==
------=_Part_21592_21580633.1247795632144
Content-Type: text/x-chdr; name="8260B.h"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="8260B.h"

LyoKICogKEMpIENvcHlyaWdodCAyMDAxCiAqIFN0dWFydCBIdWdoZXMgPHN0dWFydGhAbGluZW8u
Y29tPgogKiBUaGlzIGZpbGUgaXMgYmFzZWQgb24gc2ltaWxhciB2YWx1ZXMgZm9yIG90aGVyIGJv
YXJkcyBmb3VuZCBpbiBvdGhlcgogKiBVLUJvb3QgY29uZmlnIGZpbGVzLCBhbmQgc29tZSB0aGF0
IEkgZm91bmQgaW4gdGhlIG1wYzgyNjBhZHMgbWFudWFsLgogKgogKiBOb3RlOiBteSBib2FyZCBp
cyBhIFBJTE9UIHJldi4KICogTm90ZTogdGhlIG1wYzgyNjBhZHMgZG9lc24ndCBjb21lIHdpdGgg
YSBwcm9wZXIgRXRoZXJuZXQgTUFDIGFkZHJlc3MuCiAqCiAqIChDKSBDb3B5cmlnaHQgMjAwMy0y
MDA0IEFyYWJlbGxhIFNvZnR3YXJlIEx0ZC4KICogWXVsaSBCYXJjb2hlbiA8eXVsaUBhcmFiZWxs
YXN3LmNvbT4KICogQWRkZWQgc3VwcG9ydCBmb3IgU0RSQU0gRElNTXMgU1BEIEVFUFJPTSwgTUlJ
LCBKRkZTMi4KICogUG9ydGVkIHRvIFBRMkZBRFMtWlUgYW5kIFBRMkZBRFMtVlIgYm9hcmRzLgog
KiBQb3J0ZWQgdG8gTVBDODI3MkFEUyBib2FyZC4KICoKICogQ29weXJpZ2h0IChjKSAyMDA1IE1v
bnRhVmlzdGEgU29mdHdhcmUsIEluYy4KICogVml0YWx5IEJvcmR1ZyA8dmJvcmR1Z0BydS5tdmlz
dGEuY29tPgogKiBBZGRlZCBzdXBwb3J0IGZvciBQQ0kgYnJpZGdlIG9uIE1QQzgyNzJBRFMKICoK
ICogU2VlIGZpbGUgQ1JFRElUUyBmb3IgbGlzdCBvZiBwZW9wbGUgd2hvIGNvbnRyaWJ1dGVkIHRv
IHRoaXMKICogcHJvamVjdC4KICoKICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlv
dSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vcgogKiBtb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1z
IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcwogKiBwdWJsaXNoZWQgYnkgdGhl
IEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZgogKiB0aGUgTGlj
ZW5zZSwgb3IgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KICoKICogVGhpcyBw
cm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWws
CiAqIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdh
cnJhbnR5IG9mCiAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIg
UFVSUE9TRS4JIFNlZSB0aGUKICogR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUg
ZGV0YWlscy4KICoKICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05V
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UKICogYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5v
dCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUKICogRm91bmRhdGlvbiwgSW5jLiwgNTkgVGVt
cGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwKICogTUEgMDIxMTEtMTMwNyBVU0EKICovCgov
KgkJ5L+u5pS55Y6G5Y+yCSAyMDA5CQnkvZzogIXvvJrotbXlvrfmlocKKgkyMDA55bm0MuaciDE5
5pelCeeUtei3r+adv+agh+W/l0NPTkZJR184MjYwQiwJ6YCJ5oupRkNDMeS4uue9kee7nOS9v+eU
qO+8jEZDQzHml7bpkp/pgInmi6nkv67mlLlDTVhGQ1IKKgkJCUlNTVIgSFJDVyAsRmxhc2gg55u4
5YWz6YCJ6aG5IE1lbW9yeeebuOWFs+WvhOWtmOWZqEJSeCxPUngsRFMyMTU1ZGVmaW5lLAoqCQkJ
Q09ORklHX0JBVURSQVRFLOWinuWKoOaJk+WNsCB1LWJvb3QgaW1hZ2Ug55qE5Yi25L2c5pe26Ze0
LOS/ruaUuUJPT1RDT01NQU5ECioKKi8KI2lmbmRlZiBfX0NPTkZJR19ICiNkZWZpbmUgX19DT05G
SUdfSAoKLyoKICogSGlnaCBMZXZlbCBDb25maWd1cmF0aW9uIE9wdGlvbnMKICogKGVhc3kgdG8g
Y2hhbmdlKQogKi8KLyoqKioqKioqKioqKioqKioqKioqKiogYm9hcmQgY29uZmlnKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqLwojZGVmaW5lIENPTkZJR19WRVJTSU9OX1ZBUklBQkxFCQkx
LjAJLypVLUJvb3QgVmVyc2lvbi0tMi4yMCovCgojZGVmaW5lIHNlcmlhbCMgODI2MFRETV90b19F
dGhlck5lVAoKLyojZGVmaW5lIENPTkZJR19NUEM4MjYwQURTCTEJKk1vdG9yb2xhIFBRMiBBRFMg
ZmFtaWx5IGJvYXJkICovCiNkZWZpbmUgQ09ORklHXzgyNjBCCTEJLyogTXkgTW90b3JvbGEgUFE4
MjYwICBib2FyZCAg77yN77yNMi4xOSovCgojZGVmaW5lIENPTkZJR19DUE0yCQkxCS8qIEhhcyBh
IENQTTIgKi8KCi8qCiAqIEZpZ3VyZSBvdXQgaWYgd2UgYXJlIGJvb3RpbmcgbG93IHZpYSBmbGFz
aCBIUkNXIG9yIGhpZ2ggdmlhIHRoZSBCQ1NSLgogKi8KI2lmIChURVhUX0JBU0UgIT0gMHhGRkYw
MDAwMCkJCS8qIEJvb3QgbG93IChmbGFzaCBIUkNXKSAqLwojICAgZGVmaW5lIENPTkZJR19TWVNf
TE9XQk9PVAkJMQojZW5kaWYKCiNkZWZpbmUgQk9PVEZMQUdfQ09MRAkweDAxCS8qIE5vcm1hbCBQ
b3dlci1PbjogQm9vdCBmcm9tIEZMQVNIICAqLwojZGVmaW5lIEJPT1RGTEFHX1dBUk0JMHgwMgkv
KiBTb2Z0d2FyZSByZWJvb3QJICAgICAqLwoKLyogQURTIGZsYXZvdXJzICovCiNkZWZpbmUgQ09O
RklHX1NZU184MjYwQURTCQkxCS8qIE1QQzgyNjBBRFMgKi8KI2RlZmluZSBDT05GSUdfU1lTXzgy
NjZBRFMJCTIJLyogTVBDODI2NkFEUyAqLwojZGVmaW5lIENPTkZJR19TWVNfUFEyRkFEUwkJMwkv
KiBQUTJGQURTLVpVIG9yIFBRMkZBRFMtVlIgKi8KI2RlZmluZSBDT05GSUdfU1lTXzgyNzJBRFMJ
CTQJLyogTVBDODI3MkFEUyAqLwoKI2lmbmRlZiBDT05GSUdfQURTVFlQRQojZGVmaW5lIENPTkZJ
R19BRFNUWVBFCQlDT05GSUdfU1lTXzgyNjBBRFMKI2VuZGlmIC8qIENPTkZJR19BRFNUWVBFICov
CgojaWYgQ09ORklHX0FEU1RZUEUgPT0gQ09ORklHX1NZU184MjcyQURTCiNkZWZpbmUgQ09ORklH
X01QQzgyNzIJCTEKI2Vsc2UKI2RlZmluZSBDT05GSUdfTVBDODI2MAkJMQojZW5kaWYgLyogQ09O
RklHX0FEU1RZUEUgPT0gQ09ORklHX1NZU184MjcyQURTICovCgojZGVmaW5lIENPTkZJR19CT0FS
RF9FQVJMWV9JTklUX0YgCTEJLyogQ2FsbCBib2FyZF9lYXJseV9pbml0X2YJKi8KCi8qQ0xPQ0sq
LwojaWZuZGVmIENPTkZJR184MjYwX0NMS0lOCiNpZiBDT05GSUdfQURTVFlQRSA+PSBDT05GSUdf
U1lTX1BRMkZBRFMKI2RlZmluZSBDT05GSUdfODI2MF9DTEtJTgkxMDAwMDAwMDAJLyogaW4gSHog
Ki8KI2Vsc2UKI2RlZmluZSBDT05GSUdfODI2MF9DTEtJTgk2NjAwMDAwMAkvKiBpbiBIeiAqLwoj
ZW5kaWYKI2VuZGlmCgojZGVmaW5lIENPTkZJR19DTE9DS1NfSU5fTUhaCTI5NwovKiB0aGlzIGlz
IHN0dWZmIGNhbWUgb3V0IG9mIHRoZSBNb3Rvcm9sYSBkb2NzICovCiNpZm5kZWYgQ09ORklHX1NZ
U19MT1dCT09UCiNkZWZpbmUgQ09ORklHX1NZU19ERUZBVUxUX0lNTVIJMHhGMDAwMDAwMAojZW5k
aWYKCiNkZWZpbmUgQ09ORklHX1NZU19JTU1SCQkweEYwMDAwMDAwCS8qLS0yLjE5Ki8KCiNpZiBD
T05GSUdfQURTVFlQRSA9PSBDT05GSUdfU1lTXzgyNzJBRFMKI2RlZmluZSBDT05GSUdfU1lTX1BD
SV9JTlQJCTB4RjgyMDAwMDAKI2VuZGlmCgojZGVmaW5lIENPTkZJR19TWVNfQ0FDSEVMSU5FX1NJ
WkUJMzIJLyogRm9yIE1QQzgyNjAgQ1BVICovCgovKiA4MjYwQiBmbGFzaCBIUkNXID0wRTIyODI4
NyAqLwovKiBDUzEwIFBpbiBjb25maWcgIEJDVEwxCiogTU9EQ0tfSCA9IDAxMTEgIE1PRENLWzEt
M109MTEwICxDTEtJTj02Nk1IeiwgQ1BNID0yMDBNSHosIENvcmUgPSAzMDBNSHogCiogQ1BNIE11
bHRpcGxpY2F0aW9uIEZhY3RvciA9IDMgLENvcmUgTXVsdGlwbGljYXRpb24gRmFjdG9yID0gNC41
IAoqLwojZGVmaW5lIENPTkZJR19TWVNfSFJDV19NQVNURVIgKCAgICggSFJDV19CUFMxMSB8IEhS
Q1dfQ0lQICkJCQkgICAgfFwKCQkJICAgICggSFJDV19MMkNQQzAwIHwgSFJDV19EUFBDMTAgfCBI
UkNXX0lTQjEwMCApICAgIHxcCgkJCSAgICAoIEhSQ1dfQk1TIHwgSFJDV19NTVIwMCB8IEhSQ1df
TEJQQzAwIHwgSFJDV19BUFBDMTAgKSB8XAoJCQkgICAgKCBIUkNXX0NTMTBQQzEwIHwgSFJDV19N
T0RDS19IMDExMSApCSAgICAgXAoJCQkpCgovKiBubyBzbGF2ZXMgKi8KI2RlZmluZSBDT05GSUdf
U1lTX0hSQ1dfU0xBVkUxIAkwCiNkZWZpbmUgQ09ORklHX1NZU19IUkNXX1NMQVZFMiAJMAojZGVm
aW5lIENPTkZJR19TWVNfSFJDV19TTEFWRTMgCTAKI2RlZmluZSBDT05GSUdfU1lTX0hSQ1dfU0xB
VkU0IAkwCiNkZWZpbmUgQ09ORklHX1NZU19IUkNXX1NMQVZFNSAJMAojZGVmaW5lIENPTkZJR19T
WVNfSFJDV19TTEFWRTYgCTAKI2RlZmluZSBDT05GSUdfU1lTX0hSQ1dfU0xBVkU3IAkwCgoKI2Rl
ZmluZSBERUJVRwoKCgoKCi8qKioqKioqKioqKioqKioqKioqKioqKioqKipSZWdpc3RlcioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwojZGVmaW5l
IENPTkZJR19TWVNfVEJTQ1IJCQkvKlRpbWUgQmFzZSBTdGF0dXMgYW5kIENvbnRyb2wgKDExLTI2
KSovCiNkZWZpbmUJQ09ORklHX1NZU19QTFBSQ1IJCQkvKlBMTCwgTG93LVBvd2VyLCBhbmQgUmVz
ZXQgQ29udHJvbCBSZWdpc3RlciAoMTUtMzApKi8KI2RlZmluZQlDT05GSUdfU1lTX09SX1RJTUlO
R19TRFJBTQkJLypTRFJBTSB0aW1pbmcqLwojZGVmaW5lCUNPTkZJR19TWVNfTUFNUl9QVEEJCQkv
KnBlcmlvZGljIHRpbWVyIGZvciByZWZyZXNoKi8KCiNkZWZpbmUgQ09ORklHX1NZU19TWVBDUgkJ
MHhGRkZGRkY4MAojZGVmaW5lIENPTkZJR19TWVNfQkNSCQkJMHgxMDBDMDAwMAojZGVmaW5lIENP
TkZJR19TWVNfU0lVTUNSCQkweDg4MjVDMDAwCiNkZWZpbmUgQ09ORklHX1NZU19TQ0NSCQkJU0ND
Ul9ERkJSRzAxCgojZGVmaW5lIENPTkZJR19TWVNfUk1SCQkJUk1SX0NTUkUKI2RlZmluZSBDT05G
SUdfU1lTX1RNQ05UU0MJCShUTUNOVFNDX1NFQ3xUTUNOVFNDX0FMUnxUTUNOVFNDX1RDRnxUTUNO
VFNDX1RDRSkKI2RlZmluZSBDT05GSUdfU1lTX1BJU0NSCQkoUElTQ1JfUFN8UElTQ1JfUFRGfFBJ
U0NSX1BURSkKI2RlZmluZSBDT05GSUdfU1lTX1JDQ1IJCTAKCgoKCi8qKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqVUFSVCoqKioqKioqKioqKioqKioqKioK
ICogc2VsZWN0IHNlcmlhbCBjb25zb2xlIGNvbmZpZ3VyYXRpb24KICoKICogaWYgZWl0aGVyIENP
TkZJR19DT05TX09OX1NNQyBvciBDT05GSUdfQ09OU19PTl9TQ0MgaXMgc2VsZWN0ZWQsIHRoZW4K
ICogQ09ORklHX0NPTlNfSU5ERVggbXVzdCBiZSBzZXQgdG8gdGhlIGNoYW5uZWwgbnVtYmVyICgx
LTIgZm9yIFNNQywgMS00CiAqIGZvciBTQ0MpLgogKgogKiBpZiBDT05GSUdfQ09OU19OT05FIGlz
IGRlZmluZWQsIHRoZW4gdGhlIHNlcmlhbCBjb25zb2xlIHJvdXRpbmVzIG11c3QKICogZGVmaW5l
ZCBlbHNld2hlcmUgKGZvciBleGFtcGxlLCBvbiB0aGUgY29nZW50IHBsYXRmb3JtLCB0aGVyZSBh
cmUgc2VyaWFsCiAqIHBvcnRzIG9uIHRoZSBtb3RoZXJib2FyZCB3aGljaCBhcmUgdXNlZCBmb3Ig
dGhlIHNlcmlhbCBjb25zb2xlIC0gc2VlCiAqIGNvZ2VudC9jbWExMDEvc2VyaWFsLltjaF0pLgog
Ki8KI3VuZGVmCUNPTkZJR19DT05TX09OX1NNQwkJLyogZGVmaW5lIGlmIGNvbnNvbGUgb24gU01D
ICovCiNkZWZpbmUgQ09ORklHX0NPTlNfT05fU0NDCQkvKiBkZWZpbmUgaWYgY29uc29sZSBvbiBT
Q0MgKi8KI3VuZGVmCUNPTkZJR19DT05TX05PTkUJCS8qIGRlZmluZSBpZiBjb25zb2xlIG9uIHNv
bWV0aGluZyBlbHNlICovCiNkZWZpbmUgQ09ORklHX0NPTlNfSU5ERVgJMQkvKiB3aGljaCBzZXJp
YWwgY2hhbm5lbCBmb3IgY29uc29sZSAqLwoKI2RlZmluZSBDT05GSUdfQkFVRFJBVEUJCTk2MDAJ
LyotLTIuMTkqLwoKCgoKLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKkZMQVNIKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwojZGVm
aW5lIENPTkZJR19TWVNfRkxBU0hfQkFTRQkJVEVYVF9CQVNFIAkvKi0tMi4xOSovCiNkZWZpbmUg
Q09ORklHX1NZU19NQVhfRkxBU0hfQkFOS1MJMQkvKiBtYXggbnVtIG9mIG1lbW9yeSBiYW5rcwkq
LwojZGVmaW5lIENPTkZJR19TWVNfTUFYX0ZMQVNIX1NFQ1QJMzkJLyogbWF4IG51bSBvZiBzZWN0
cyBvbiBvbmUgY2hpcCAqLwojZGVmaW5lIENPTkZJR19TWVNfRkxBU0hfU0laRQkJCTB4NDAwMDAw
CS8qNE0tLTIuMTkqLwojZGVmaW5lIENPTkZJR19TWVNfRkxBU0hfRVJBU0VfVE9VVAk4MDAwMDAw
MDAwMDAJLyogVGltZW91dCBmb3IgRmxhc2ggRXJhc2UgKGluIG1zKSAgICAqLwojZGVmaW5lIENP
TkZJR19TWVNfRkxBU0hfV1JJVEVfVE9VVAk5MDAwMDAwMDAwMDAwCS8qIFRpbWVvdXQgZm9yIEZs
YXNoIFdyaXRlIChpbiBtcykgICAgKi8KI2RlZmluZSBDT05GSUdfU1lTX0ZMQVNIX0xPQ0tfVE9V
VAk1MDAwMDAwMDAwMDAJLyogVGltZW91dCBmb3IgRmxhc2ggU2V0IExvY2sgQml0IChpbiBtcykg
Ki8KI2RlZmluZSBDT05GSUdfU1lTX0ZMQVNIX1VOTE9DS19UT1VUCTEwMDAwMDAwMAkvKiBUaW1l
b3V0IGZvciBGbGFzaCBDbGVhciBMb2NrIEJpdHMgKGluIG1zKSAqLwojZGVmaW5lIENPTkZJR19T
WVNfRkxBU0hfUFJPVEVDVElPTgkJLyogIlJlYWwiIChoYXJkd2FyZSkgc2VjdG9ycyBwcm90ZWN0
aW9uICovCi8qI2RlZmluZSBDT05GSUdfU1lTX0RJUkVDVF9GTEFTSF9URlRQKi8vKi0tMi4yMCov
CgovKkJSMCBPUjAqLwojZGVmaW5lIENPTkZJR19TWVNfQlIwX1BSRUxJTQkJKENPTkZJR19TWVNf
RkxBU0hfQkFTRSB8IDB4MDAwMDE4MDEpCiNkZWZpbmUgQ09ORklHX1NZU19PUjBfUFJFTElNCQkw
eEZGQzAxQzU0CgovKlBoeXNpY2FsIHN0YXJ0IGFkZHJlc3Mgb2YgYm9vdCBtb25pdG9yIGNvZGUg
KHNldCBieQoJCW1ha2UgY29uZmlnIGZpbGVzIHRvIGJlIHNhbWUgYXMgdGhlIHRleHQgYmFzZSBh
ZGRyZXNzCgkJKFRFWFRfQkFTRSkgdXNlZCB3aGVuIGxpbmtpbmcpIC0gc2FtZSBhcwoJCUNPTkZJ
R19TWVNfRkxBU0hfQkFTRSB3aGVuIGJvb3RpbmcgZnJvbSBmbGFzaC4qLwojZGVmaW5lIENPTkZJ
R19TWVNfTU9OSVRPUl9CQVNFICAgIFRFWFRfQkFTRQoKCgoKCi8qKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqU0RSQU0qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKi8KIC8qKiBTRFJBTV9TSVpFIGRlZmluZSBpbiA4MjYwQi5jKi8KI2Rl
ZmluZSBDT05GSUdfU1lTX1NEUkFNX0JBU0UJCTB4MDAwMDAwMDAJLypQaHlzaWNhbCBzdGFydCBh
ZGRyZXNzIG9mIFNEUkFNLiBfTXVzdF8gYmUgMCBoZXJlLiovCgoKI2RlZmluZSBDT05GSUdfU1lT
X0JSMV9QUkVMSU0JCTB4MDAwMDAwNDEJCS8qU0RSQU0JIE9OIEJSMSAqLwojZGVmaW5lIENPTkZJ
R19TWVNfT1IxX1BSRUxJTQkJMHhGODAwMkIwMAojZGVmaW5lIENPTkZJR19TWVNfT1IxCQkJMHhG
ODAwMkIwMAoKI2RlZmluZQlDT05GSUdfU1lTX1BTRE1SCQkweEMzMkVCNDUyCgojZGVmaW5lCUNP
TkZJR19TWVNfUFNSVAkJCTB4MDAwZQoKI2RlZmluZSBDT05GSUdfU1lTX0xTRE1SCQkweDAwODZB
NTIyCiNkZWZpbmUgQ09ORklHX1NZU19MU1JUCQkJMHgyMQojZGVmaW5lCUNPTkZJR19TWVNfTVBU
UFIJCTB4NDAwMAoKI2lmbmRlZiBDT05GSUdfU0RSQU1fUEJJCiNkZWZpbmUgQ09ORklHX1NEUkFN
X1BCSQkwIC8qIEJ5IGRlZmF1bHQsIHVzZSBiYW5rLWJhc2VkIGludGVybGVhdmluZyAqLwojZW5k
aWYKCi8qU2l6ZSBvZiBtZW1vcnkgcmVzZXJ2ZWQgZm9yIG1vbml0b3IgY29kZSwgdXNlZCB0bwoJ
CWRldGVybWluZSBfYXRfY29tcGlsZV90aW1lXyAoISkgaWYgdGhlIGVudmlyb25tZW50IGlzCgkJ
ZW1iZWRkZWQgd2l0aGluIHRoZSBVLUJvb3QgaW1hZ2UsIG9yIGluIGEgc2VwYXJhdGUKCQlmbGFz
aCBzZWN0b3IuKi8KI2RlZmluZSBDT05GSUdfU1lTX01PTklUT1JfTEVOCQkoMjU2IDw8IDEwKQkv
KiBSZXNlcnZlIDI1NiBrQiBmb3IgTW9uaXRvcgkqLwojZGVmaW5lIENPTkZJR19TWVNfQk9PVE1B
UFNaCQkoOCA8PCAyMCkJLyogSW5pdGlhbCBNZW1vcnkgbWFwIGZvciBMaW51eCAqLwoKLypTaXpl
IG9mIERSQU0gcmVzZXJ2ZWQgZm9yIG1hbGxvYygpIHVzZSovCiNpZmRlZiBDT05GSUdfQlpJUDIK
I2RlZmluZSBDT05GSUdfU1lTX01BTExPQ19MRU4JCSg0MDk2IDw8IDEwKQkvKiBSZXNlcnZlIDQg
TUIgZm9yIG1hbGxvYygpCSovCiNlbHNlCiNkZWZpbmUgQ09ORklHX1NZU19NQUxMT0NfTEVOCQko
MTI4IDw8IDEwKQkvKiBSZXNlcnZlIDEyOCBLQiBmb3IgbWFsbG9jKCkJKi8KI2VuZGlmIC8qIENP
TkZJR19CWklQMiAqLwoKCgoKCi8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKipJTklUIFJB
TSoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
Ki8KI2RlZmluZSBDT05GSUdfU1lTX0lOSVRfUkFNX0FERFIJCUNPTkZJR19TWVNfSU1NUgkvKi0t
MjAwOS41LjEzKi8KI2RlZmluZSBDT05GSUdfU1lTX0lOSVRfUkFNX0VORAkJMHgyMDAwCS8qIEVu
ZCBvZiB1c2VkIGFyZWEgaW4gRFBSQU0JKi8KI2RlZmluZSBDT05GSUdfU1lTX0dCTF9EQVRBX1NJ
WkUJMTI4CS8qIHNpemUgaW4gYnl0ZXMgcmVzZXJ2ZWQgZm9yIGluaXRpYWwgZGF0YSAqLwojZGVm
aW5lIENPTkZJR19TWVNfR0JMX0RBVEFfT0ZGU0VUCShDT05GSUdfU1lTX0lOSVRfUkFNX0VORCAt
IENPTkZJR19TWVNfR0JMX0RBVEFfU0laRSkKI2RlZmluZSBDT05GSUdfU1lTX0lOSVRfU1BfT0ZG
U0VUCUNPTkZJR19TWVNfR0JMX0RBVEFfT0ZGU0VUCgoKCgoKCgoKLyoqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqbmV0KioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKgogKiBzZWxlY3QgZXRoZXJuZXQgY29uZmlndXJhdGlvbgogICAq
CiAqIGlmIGVpdGhlciBDT05GSUdfRVRIRVJfT05fU0NDIG9yIENPTkZJR19FVEhFUl9PTl9GQ0Mg
aXMgc2VsZWN0ZWQsIHRoZW4KICogQ09ORklHX0VUSEVSX0lOREVYIG11c3QgYmUgc2V0IHRvIHRo
ZSBjaGFubmVsIG51bWJlciAoMS00IGZvciBTQ0MsIDEtMwogKiBmb3IgRkNDKQogKgogKiBpZiBD
T05GSUdfRVRIRVJfTk9ORSBpcyBkZWZpbmVkLCB0aGVuIGVpdGhlciB0aGUgZXRoZXJuZXQgcm91
dGluZXMgbXVzdCBiZQogKiBkZWZpbmVkIGVsc2V3aGVyZSAoYXMgZm9yIHRoZSBjb25zb2xlKSwg
b3IgQ09ORklHX0NNRF9ORVQgbXVzdCBiZSB1bnNldC4KICovCiN1bmRlZglDT05GSUdfRVRIRVJf
T05fU0NDCQkvKiBkZWZpbmUgaWYgZXRoZXIgb24gU0NDICAgKi8KI2RlZmluZSBDT05GSUdfRVRI
RVJfT05fRkNDCQkvKiBkZWZpbmUgaWYgZXRoZXIgb24gRkNDICAgKi8KI3VuZGVmCUNPTkZJR19F
VEhFUl9OT05FCQkvKiBkZWZpbmUgaWYgZXRoZXIgb24gc29tZXRoaW5nIGVsc2UgKi8KCiNpZmRl
ZiBDT05GSUdfRVRIRVJfT05fRkNDCgoJI2RlZmluZSBDT05GSUdfRVRIRVJfSU5ERVgJMQkvKiB3
aGljaCBTQ0MvRkNDIGNoYW5uZWwgZm9yIGV0aGVybmV0IC0tMi4xOSovCgojaWYgICBDT05GSUdf
RVRIRVJfSU5ERVggPT0gMQoKCSMgZGVmaW5lIENPTkZJR19TWVNfUEhZX0FERFIJCTAKCS8qIyBk
ZWZpbmUgQ09ORklHX1NZU19DTVhGQ1JfVkFMVUUJKENNWEZDUl9SRjFDU19DTEsxMSB8IENNWEZD
Ul9URjFDU19DTEsxMCkqLwoJIyBkZWZpbmUgQ09ORklHX1NZU19DTVhGQ1JfVkFMVUUJKENNWEZD
Ul9SRjFDU19DTEsxMSB8IENNWEZDUl9URjFDU19DTEsxMikJLyrvvI3vvI0yLjE5Ki8KCSMgZGVm
aW5lIENPTkZJR19TWVNfQ01YRkNSX01BU0sJCShDTVhGQ1JfRkMxIHwgQ01YRkNSX1JGMUNTX01T
SyB8IENNWEZDUl9URjFDU19NU0spCgojZWxpZiBDT05GSUdfRVRIRVJfSU5ERVggPT0gMgoKI2lm
IENPTkZJR19BRFNUWVBFID09IENPTkZJR19TWVNfODI3MkFEUwkvKiBSeENMSyBpcyBDTEsxNSwg
VHhDTEsgaXMgQ0xLMTYgKi8KIyBkZWZpbmUgQ09ORklHX1NZU19QSFlfQUREUgkJMwojIGRlZmlu
ZSBDT05GSUdfU1lTX0NNWEZDUl9WQUxVRQkoQ01YRkNSX1JGMkNTX0NMSzE1IHwgQ01YRkNSX1RG
MkNTX0NMSzE2KQojZWxzZQkJCQkJLyogUnhDTEsgaXMgQ0xLMTMsIFR4Q0xLIGlzIENMSzE0ICov
CiMgZGVmaW5lIENPTkZJR19TWVNfUEhZX0FERFIJCTAKIyBkZWZpbmUgQ09ORklHX1NZU19DTVhG
Q1JfVkFMVUUJKENNWEZDUl9SRjJDU19DTEsxMyB8IENNWEZDUl9URjJDU19DTEsxNCkKI2VuZGlm
IC8qIENPTkZJR19BRFNUWVBFID09IENPTkZJR19TWVNfODI3MkFEUyAqLwoKIyBkZWZpbmUgQ09O
RklHX1NZU19DTVhGQ1JfTUFTSwkoQ01YRkNSX0ZDMiB8IENNWEZDUl9SRjJDU19NU0sgfCBDTVhG
Q1JfVEYyQ1NfTVNLKQoKI2VuZGlmCS8qIENPTkZJR19FVEhFUl9JTkRFWCAqLwoKI2RlZmluZSBD
T05GSUdfU1lTX0NQTUZDUl9SQU1UWVBFCTAJCS8qIEJEcyBhbmQgYnVmZmVycyBvbiA2MHggYnVz
ICovCiNkZWZpbmUgQ09ORklHX1NZU19GQ0NfUFNNUgkJKEZDQ19QU01SX0ZERSB8IEZDQ19QU01S
X0xQQikgIC8qIEZ1bGwgZHVwbGV4ICovCgojZGVmaW5lIENPTkZJR19NSUkJCQkvKiBNSUkgUEhZ
IG1hbmFnZW1lbnQJCSovCiNkZWZpbmUgQ09ORklHX0JJVEJBTkdNSUkJCS8qIGJpdC1iYW5nIE1J
SSBQSFkgbWFuYWdlbWVudAkqLwovKgogKiBHUElPIHBpbnMgdXNlZCBmb3IgYml0LWJhbmdlZCBN
SUkgY29tbXVuaWNhdGlvbnMKICovCiNkZWZpbmUgTURJT19QT1JUCTIJCS8qIFBvcnQgQyAqLwoK
I2RlZmluZSBDT05GSUdfU1lTX01ESU9fUElOCTB4MDA0MDAwMDAJLyogUEM5CSovCiNkZWZpbmUg
Q09ORklHX1NZU19NRENfUElOCTB4MDAyMDAwMDAJLyogUEMxMCAqLwoKI2RlZmluZSBNRElPX0FD
VElWRQkoaW9wLT5wZGlyIHw9ICBDT05GSUdfU1lTX01ESU9fUElOKQojZGVmaW5lIE1ESU9fVFJJ
U1RBVEUJKGlvcC0+cGRpciAmPSB+Q09ORklHX1NZU19NRElPX1BJTikKI2RlZmluZSBNRElPX1JF
QUQJKChpb3AtPnBkYXQgJiAgQ09ORklHX1NZU19NRElPX1BJTikgIT0gMCkKCiNkZWZpbmUgTURJ
TyhiaXQpCWlmKGJpdCkgaW9wLT5wZGF0IHw9ICBDT05GSUdfU1lTX01ESU9fUElOOyBcCgkJCWVs
c2UJaW9wLT5wZGF0ICY9IH5DT05GSUdfU1lTX01ESU9fUElOCgojZGVmaW5lIE1EQyhiaXQpCWlm
KGJpdCkgaW9wLT5wZGF0IHw9ICBDT05GSUdfU1lTX01EQ19QSU47IFwKCQkJZWxzZQlpb3AtPnBk
YXQgJj0gfkNPTkZJR19TWVNfTURDX1BJTgoKI2RlZmluZSBNSUlERUxBWQl1ZGVsYXkoMSkKCiNl
bmRpZiAvKiBDT05GSUdfRVRIRVJfT05fRkNDICovCgojZGVmaW5lIENPTkZJR19FVEhBRERSICAg
ICAgICAgIDAwOjEwOkVDOkQwOjMwOjg4CgoKCgovKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqZW52aXJvbm1lbnQqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKiovCi8qKiAiZW1iZWRkZWQiIGluIHRoZSB0ZXh0IHNlZ21lbnQgd2l0aCB0
aGUgVS1Cb290IGNvZGUgLS02LjQK55Sx5LqOVS1Cb2905Luj56CB6YCa5bi46L6+5YiwMTAwS0Ll
t6blj7PvvIzkuJTlv4Xpobvku47lnLDlnYAw5aSE5byA5aeL77yM5oyJ54Wn6L+Z5qC355qE5YiG
6YWN5pa55byP77yM5oiR5Lus5bCG5LiN5b6X5LiN5Li6ZW525YiG6YWN5LiA5Z2XNjRLQueahHNl
Y3Rvcu+8jArogIzlrp7pmYXkuK3kvb/nlKjliLDnmoTlj6/og73lj6rmmK/lhbbkuK3nmoTlh6Dn
mb7lrZfoioLvvIFVLUJvb3Tov5jkvJrkuLplbnblnKhSQU3kuK3kv53mjIHkuIDlnZflkIzmoLfl
pKflsI/nmoTnqbrpl7TvvIzov5nlsLHpgKDmiJBST03lkoxSQU3nqbrpl7TkuI3lv4XopoHnmoTm
tarotLnjgIIKIAkJ5Li65LqG5bC95Y+v6IO95Zyw5YeP5bCR6LWE5rqQ5rWq6LS577yM5ZCM5pe2
5L+d6K+B57O757uf55qE5YGl5aOu5oCn77yM5oiR5Lus5Y+v5Lul5oqKZW525pS+572u5ZyoRmxh
c2jkuK3lrrnph4/mnIDlsI/nmoRzZWN0b3Lph4zjgIIK6L+Z5qC377yMZW525bWM5YWl77yIZW1i
ZWTvvInliLBVLUJvb3TnmoTku6PnoIHmrrXjgILlnKhjb21tb24vZW52aXJvbm1lbnQuaOS4reS8
muavlOi+g2VuduWSjG1vbml0b3LnmoTojIPlm7TvvIzlpoLmnpznoa7lrpplbnbkvY3kuo5tb25p
dG9y5YaF77yMCuWImeWumuS5iUVOVl9JU19FTUJFRERFROOAggoqKioqKioqKioqKiogZGVmaW5l
IGFzIGZvbGxvdyBpbiAgY29tbW9uL2Vudmlyb25tZW50LmgqKioqKioqKioqKioqKioqKioqKioq
KgojIGlmIChDRkdfRU5WX0FERFIgPj0gQ0ZHX01PTklUT1JfQkFTRSkgJiYgXAogICAgIChDRkdf
RU5WX0FERFIrQ0ZHX0VOVl9TSVpFKSA8PSAoQ0ZHX01PTklUT1JfQkFTRSArIENGR19NT05JVE9S
X0xFTikKIyAgZGVmaW5lIEVOVl9JU19FTUJFRERFRCAgIDEKIyBlbmRpZiAKKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwoKLyogYWxsb3cgc2VyaWFsIGFu
ZCBldGhhZGRyIHRvIGJlIG92ZXJ3cml0dGVuICovCi8qI2RlZmluZSBDT05GSUdfRU5WX09WRVJX
UklURSovCgovKiBFTlYgZW1iZWRkZWQgaW4gdGhlIHRleHQgc2VnbWVudCBhbmQgSU4gZmxhc2gq
LwojICBkZWZpbmUgQ09ORklHX0VOVl9JU19JTl9GTEFTSAkxCiMgIGRlZmluZSBDT05GSUdfRU5W
X1NFQ1RfU0laRQkJMHg0MDAJCS8qLS02LjQgc2VjdG9yIGluIDB4MjAwMTAwMDAtMHgyMDAxNDAw
MCovCQojICBkZWZpbmUgQ09ORklHX0VOVl9BRERSCQkweDIwMDEwMDAwCS8qLS0gNi40IGFkZHJl
c3MgaW4gZmxhc2ggKi8KCgovKgogKiBDb21tYW5kIGxpbmUgY29uZmlndXJhdGlvbi4KICovCiNp
bmNsdWRlIDxjb25maWdfY21kX2RlZmF1bHQuaD4KCiNkZWZpbmUgQ09ORklHX0NNRF9BU0tFTlYK
I2RlZmluZSBDT05GSUdfQ01EX0NBQ0hFCiNkZWZpbmUgQ09ORklHX0NNRF9DRFAKI2RlZmluZSBD
T05GSUdfQ01EX0RIQ1AKI2RlZmluZSBDT05GSUdfQ01EX0RJQUcKI2RlZmluZSBDT05GSUdfQ01E
X0kyQwojZGVmaW5lIENPTkZJR19DTURfSU1NQVAKI2RlZmluZSBDT05GSUdfQ01EX0lSUQojZGVm
aW5lIENPTkZJR19DTURfSkZGUzIKI2RlZmluZSBDT05GSUdfQ01EX01JSQojZGVmaW5lIENPTkZJ
R19DTURfUENJCiNkZWZpbmUgQ09ORklHX0NNRF9QSU5HCiNkZWZpbmUgQ09ORklHX0NNRF9QT1JU
SU8KI2RlZmluZSBDT05GSUdfQ01EX1JFR0lORk8KI2RlZmluZSBDT05GSUdfQ01EX1NBVkVTCiNk
ZWZpbmUgQ09ORklHX0NNRF9TRFJBTQoKI2RlZmluZSBDT05GSUdfQ01EX0VMRgkJLyogRUxGIChW
eFdvcmtzKSBsb2FkL2Jvb3QgY21kCSovCgovKkNNRCB1bmRlZiovCiN1bmRlZiBDT05GSUdfQ01E
X1hJTUcKCiNpZiBDT05GSUdfQURTVFlQRSA9PSBDT05GSUdfU1lTXzgyNzJBRFMKICAgICN1bmRl
ZiBDT05GSUdfQ01EX1NEUkFNCiAgICAjdW5kZWYgQ09ORklHX0NNRF9JMkMKCiNlbGlmIENPTkZJ
R19BRFNUWVBFID49IENPTkZJR19TWVNfUFEyRkFEUwogICAgI3VuZGVmIENPTkZJR19DTURfU0RS
QU0KICAgICN1bmRlZiBDT05GSUdfQ01EX0kyQwogICAgI3VuZGVmIENPTkZJR19DTURfUENJCgoj
ZWxzZQogICAgI3VuZGVmIENPTkZJR19DTURfUENJCgojZW5kaWYgLyogQ09ORklHX0FEU1RZUEUg
Pj0gQ09ORklHX1NZU19QUTJGQURTICovCgoKI2RlZmluZSBDT05GSUdfQk9PVERFTEFZCTgJCS8q
IGF1dG9ib290IGFmdGVyIDUgc2Vjb25kcyAqLwovKiNkZWZpbmUgQ09ORklHX0JPT1RDT01NQU5E
CSJib290bSAweDIwMDQwMDAwIDB4MjAyMDAwMDAiCSogYXV0b2Jvb3QgY29tbWFuZCAqLwoKI2Rl
ZmluZQlDT05GSUdfQk9PVEZJTEUgIHVJbWFnZQoKLyojZGVmaW5lIENPTkZJR19CT09UQVJHUwki
cm9vdD0vZGV2L210ZGJsb2NrMiIKLyoiYm9vdHJldHJ5IiBlbnZpcm9ubWVudCB2YXJpYWJsZSBk
ZWZpbmUgaW4gZG9jL1JFQURNRS5hdXRvYm9vdCAtLTIuMjAqLwovKiNkZWZpbmUgIENPTkZJR19C
T09UX1JFVFJZX1RJTUUJCTIwKi8KI2RlZmluZSBDT05GSUdfQk9PVEFSR1MJImNvbnNvbGU9dHR5
Q1BNMCw5NjAwIHJvb3Q9L2Rldi9yYW0wIgojZGVmaW5lICBDT05GSUdfQk9PVF9SRVRSWV9NSU4J
CTIwCgojZGVmaW5lIENPTkZJR19BVVRPQk9PVF9QUk9NUFQgCSJhdXRvYm9vdCBpbiAlZCBzZWNv
bmRzIFxuIixib290ZGVsYXkKCiNkZWZpbmUgCUNPTkZJR19SVENfTVBDOHh4Ci8qCiNkZWZpbmUg
CUNPTkZJR19DTURfREFURQojZGVmaW5lCUNPTkZJR19DT05TT0xFX1RJTUUKKi8KI2lmIGRlZmlu
ZWQoQ09ORklHX0NNRF9LR0RCKQojdW5kZWYJQ09ORklHX0tHREJfT05fU01DCQkvKiBkZWZpbmUg
aWYga2dkYiBvbiBTTUMgKi8KI2RlZmluZSBDT05GSUdfS0dEQl9PTl9TQ0MJCS8qIGRlZmluZSBp
ZiBrZ2RiIG9uIFNDQyAqLwojdW5kZWYJQ09ORklHX0tHREJfTk9ORQkJLyogZGVmaW5lIGlmIGtn
ZGIgb24gc29tZXRoaW5nIGVsc2UgKi8KI2RlZmluZSBDT05GSUdfS0dEQl9JTkRFWAkyCS8qIHdo
aWNoIHNlcmlhbCBjaGFubmVsIGZvciBrZ2RiICovCiNkZWZpbmUgQ09ORklHX0tHREJfQkFVRFJB
VEUJMTE1MjAwCS8qIHNwZWVkIHRvIHJ1biBrZ2RiIHNlcmlhbCBwb3J0IGF0ICovCiNlbmRpZgoK
I2RlZmluZSBDT05GSUdfQlpJUDIJLyogaW5jbHVkZSBzdXBwb3J0IGZvciBiemlwMiBjb21wcmVz
c2VkIGltYWdlcyAqLwojdW5kZWYJQ09ORklHX1dBVENIRE9HIC8qIGRpc2FibGUgcGxhdGZvcm0g
c3BlY2lmaWMgd2F0Y2hkb2cgKi8KCiNpZiBkZWZpbmVkKENPTkZJR19DTURfS0dEQikKIyAgZGVm
aW5lIENPTkZJR19TWVNfQ0FDSEVMSU5FX1NISUZUCTUJLyogbG9nIGJhc2UgMiBvZiB0aGUgYWJv
dmUgdmFsdWUgKi8KI2VuZGlmCgovKgogKiBNaXNjZWxsYW5lb3VzIGNvbmZpZ3VyYWJsZSBvcHRp
b25zCiAqLwojZGVmaW5lIENPTkZJR19TWVNfSFVTSF9QQVJTRVIKI2RlZmluZSBDT05GSUdfU1lT
X1BST01QVF9IVVNIX1BTMiAiPiAiCiNkZWZpbmUgQ09ORklHX1NZU19MT05HSEVMUAkvKiBsb25n
IGhlbHAgbWVzc2FnZXMgaW5jbHVkZWQgdW5kZWYgdG8gc2F2ZSBtZW1vcnkqLwojZGVmaW5lIENP
TkZJR19TWVNfUFJPTVBUCSJbdS1ib290XTogIgkJLyogTW9uaXRvciBDb21tYW5kIFByb21wdCAg
ICovCgojaWYgZGVmaW5lZChDT05GSUdfQ01EX0tHREIpCiNkZWZpbmUgQ09ORklHX1NZU19DQlNJ
WkUJMTAyNAkJLyogQ29uc29sZSBJL08gQnVmZmVyIFNpemUgICovCiNlbHNlCiNkZWZpbmUgQ09O
RklHX1NZU19DQlNJWkUJMjU2CQkJLyogQ29uc29sZSBJL08gQnVmZmVyIFNpemUgICovCiNlbmRp
ZgoKI2RlZmluZSBDT05GSUdfU1lTX1BCU0laRSAoQ09ORklHX1NZU19DQlNJWkUrc2l6ZW9mKENP
TkZJR19TWVNfUFJPTVBUKSsxNikJLyogUHJpbnQgQnVmZmVyIFNpemUgKi8KI2RlZmluZSBDT05G
SUdfU1lTX01BWEFSR1MJMTYJCQkvKiBtYXggbnVtYmVyIG9mIGNvbW1hbmQgYXJncwkqLwojZGVm
aW5lIENPTkZJR19TWVNfQkFSR1NJWkUJQ09ORklHX1NZU19DQlNJWkUJLyogQm9vdCBBcmd1bWVu
dCBCdWZmZXIgU2l6ZQkqLwoKI2RlZmluZSBDT05GSUdfU1lTX0JBVURSQVRFX1RBQkxFCXsgOTYw
MCwgMTkyMDAsIDM4NDAwLCA1NzYwMCwgMTE1MjAwLCAyMzA0MDAgfQoKI2RlZmluZSBDT05GSUdf
U1lTX01FTVRFU1RfU1RBUlQJMHgwMDEwMDAwMAkvKiBtZW10ZXN0IHdvcmtzIG9uICovCiNkZWZp
bmUgQ09ORklHX1NZU19NRU1URVNUX0VORAkJMHgwMGYwMDAwMAkvKiAxIC4uLiAxNSBNQiBpbiBE
UkFNCSovCgovKiNkZWZpbmUgQ09ORklHX1NZU19MT0FEX0FERFIJMHg0MDAwMDAJLyogZGVmYXVs
dCBsb2FkIGFkZHJlc3MgKi8KI2RlZmluZQlDT05GSUdfU1lTX0xPQURfQUREUgkJMHg4MDAwMDAJ
LyotLTYuNCovCQoKI2RlZmluZSBDT05GSUdfU1lTX0haCQkJMTAwMAkvKiBkZWNyZW1lbnRlciBm
cmVxOiAxIG1zIHRpY2tzICovCgovKgogKiBCT09UUCBvcHRpb25zCiAqLwojZGVmaW5lIENPTkZJ
R19CT09UUF9CT09URklMRVNJWkUKI2RlZmluZSBDT05GSUdfQk9PVFBfQk9PVFBBVEgKI2RlZmlu
ZSBDT05GSUdfQk9PVFBfR0FURVdBWQojZGVmaW5lIENPTkZJR19CT09UUF9IT1NUTkFNRQoKLyoj
ZGVmaW5lIENPTkZJR19TWVNfUkVTRVRfQUREUkVTUwkweDA0NDAwMDAwKi8KI2RlZmluZQlDT05G
SUdfU1lTX1JFU0VUX0FERFJFU1MJCTB4MjAwMDAxMDAJCQkvKi0tMjAwOS42LjIqLwoKLypJUGFk
ZHJlc3MgKi8KI2RlZmluZQlDT05GSUdfSVBBRERSCQkxMi4xMy40NS4xNjAKI2RlZmluZQlDT05G
SUdfU0VSVkVSSVAJMTIuMTMuNDUuMTU4Ci8qICNkZWZpbmUJQ09ORklHX1BIWV9BRERSCQlUaGUg
YWRkcmVzcyBvZiBQSFkgb24gTUlJIGJ1cyAqLwovKkludGVsIExYVDk3MUEgbmVlZCBleHRyYSBk
ZWxheSBhZnRlciByZXNldCwzMDAgaXMgbWluaW11bSAqLwojZGVmaW5lCQlDT05GSUdfUEhZX1JF
U0VUX0RFTEFZCTMwMAkKCi8qICNkZWZpbmUJQ09ORklHX1BIWV9HSUdFCXN1cHBvcnQgZm9yIHNw
ZWVkL2R1cGxleCBkZXRlY3Rpb24gb2YgZ2lnYWJpdCBQSFkgaXMgaW5jbHVkZWQuKi8KCi8qI2Rl
ZmluZSBDT05GSUdfU1RBVFVTX0xFRAkqZGlzcGxheSB0aGUgY3VycmVudCBzdGF0dXMgdXNpbmcg
YSBMRUQuKi8KCi8qc2hvdyB0aGUgc3lzdGVtJ3MgYm9vdCBwcm9ncmVzcyBvbiBzb21lIGRpc3Bs
YXkgY2FsbGluZyBhIHVzZXItcHJvdmlkZWQgZnVuY3Rpb24gInNob3dfYm9vdF9wcm9ncmVzcyhp
bnQpKi8KI2RlZmluZQlDT05GSUdfU0hPV19CT09UX1BST0dSRVNTCQoKCgoKCgoKCQoKLyoqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqdnhXb3JrcyoqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKiovCi8qYXV0aG9yIGRlZmluZSBhcyBmb2xsb3cgLS0yLjI1
Ki8KLypkZWZpbmUgdnhXb3JrcyBib290IHBhcmFtZXRlcnM6LSAqLwovKk5vdGU6IElmIGEgImJv
b3RhcmdzIiBlbnZpcm9ubWVudCBpcyBkZWZpbmVkLCBpdCB3aWxsIG92ZXJ3cmlkZQoJCXRoZSBk
ZWZhdWx0cyBkaXNjdXNzZWQganVzdCBhYm92ZS4qLwovKiNkZWZpbmUJYm9vdF92eFdvcmtzKi8g
CiNpZmRlZgkJYm9vdF92eFdvcmtzCiNkZWZpbmUJQ09ORklHX1NZU19WWFdPUktTX0JPT1RfREVW
SUNFIAl2eFdvcmtzX3JvbS5iaW4JLyogVGhlIHZ4d29ya3MgZGV2aWNlIG5hbWUgKi8KI2RlZmlu
ZQlDT05GSUdfU1lTX1ZYV09SS1NfTUFDX1BUUiBFdGhlcm5ldCAgICAgLyogNiBieXRlIE1BIC1h
ZGRyZXNzICAgICAgKi8KI2RlZmluZQlDT05GSUdfU1lTX1ZYV09SS1NfU0VSVkVSTkFNRSAgICAg
ICAgICAgLyogTmFtZSBvZiB0aGUgc2VydmVyICAgICAgKi8KI2RlZmluZQlDT05GSUdfU1lTX1ZY
V09SS1NfQk9PVF9BRERSICAgICAgICAgICAweDIwMDQwMDAwIC8qIEFkZHJlc3Mgb2YgYm9vdCBw
YXJhbWV0ZXJzKi8KI2RlZmluZQlDT05GSUdfU1lTX1ZYV09SS1NfQUREX1BBUkFNUwkJCQkgIm1v
dGZjYygwLDApIFBvd2VycGM1OiBlPTEyLjEzLjQ1LjE2MCBoPTEyLjEzLjQ1LjE1OCB1PWFkbWlu
IHB3PWFkbWluIG89bW90ZmNjIiAgCiNlbmRpZgoKCgoKCi8qKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKipvdGhlcioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqLwojZGVmaW5lIENPTkZJR19PRl9MSUJGRFQJMQojZGVmaW5lIENPTkZJR19PRl9CT0FS
RF9TRVRVUAkxCiNkZWZpbmUgQ09ORklHX09GX1NURE9VVF9WSUFfQUxJQVMJMQojaWYgZGVmaW5l
ZChDT05GSUdfT0ZfTElCRkRUKQojZGVmaW5lIAlPRl9DUFUJCQkiY3B1IgojZGVmaW5lIAlPRl9U
QkNMSwkJKGJkLT5iaV9idXNmcmVxIC8gNCkKI2RlZmluZSAJT0ZfU09DIAkJc29jQGYwMDAwMDAw
CS8qLSBUaGUgcHJvcGVyIG5hbWUgb2YgdGhlIHNvYyBub2RlLiovCiNkZWZpbmUJT0ZfVEJDTEsg
CTAJCQkJCS8qLSBUaGUgdGltZWJhc2UgZnJlcXVlbmN5LiovCiNkZWZpbmUJT0ZfU1RET1VUX1BB
VEggIi9zb2MvY3BtL3NlcmlhbEAxMWEwMCIJLyotIFRoZSBwYXRoIHRvIHRoZSBjb25zb2xlIGRl
dmljZSovCiNkZWZpbmUJQ09ORklHX09GX0JPT1RfQ1BVCSJjcHVAMCIKI2VuZGlmCgojZGVmaW5l
IENPTkZJR19TWVNfSElEMF9JTklUCQkwCiNkZWZpbmUgQ09ORklHX1NZU19ISUQwX0ZJTkFMCQko
SElEMF9JQ0UgfCBISUQwX0lGRU0gfCBISUQwX0FCRSApCgojZGVmaW5lIENPTkZJR19TWVNfSElE
MgkJMAoKI2RlZmluZSBSUzIzMkVOXzEJCTB4MDIwMDAwMDIKI2RlZmluZSBSUzIzMkVOXzIJCTB4
MDEwMDAwMDEKI2RlZmluZSBGRVRISUVOMQkJMHgwODAwMDAwOAojZGVmaW5lIEZFVEgxX1JTVAkJ
MHgwNDAwMDAwNAojZGVmaW5lIEZFVEhJRU4yCQkweDEwMDAwMDAwCiNkZWZpbmUgRkVUSDJfUlNU
CQkweDA4MDAwMDAwCiNkZWZpbmUgQkNTUl9QQ0lfTU9ERQkJMHgwMTAwMDAwMAoKCgoKCi8qKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqRFMyMTU1KioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCiN1bmRlZglJTkNM
VURFX01DQ19FMV9EUzIxNTUKLyojZGVmaW5lCUlOQ0xVREVfTUNDX0UxX0RTMjE1NSovCgojaWZk
ZWYgSU5DTFVERV9NQ0NfRTFfRFMyMTU1CgojZGVmaW5lIENPTkZJR19TWVNfQlIyX1BSRUxJTQkJ
MHgzMDAwMDgwMQojZGVmaW5lIENPTkZJR19TWVNfT1IyX1BSRUxJTQkJMHhGRkZGODgzNAoKI2Rl
ZmluZSBEUzIxNTVfQURSUwkJCTB4MTAwMDAwMDAKI2RlZmluZSBEUzIxNTVfU0laRQkJCTB4MTAw
MDAKI2RlZmluZSBEczIxNTVfQWRkcl9PZmZzZXQJCTB4MTAwCgojZW5kaWYJCS8qRFMyMTU1IGRl
ZmluZSovCgoKCgoKCgoKCi8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioKKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKiBlbmQgODI2MCBjb25maWcgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqCioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKiovCgoKCgoKLyoJSTJDICovCiNpZiBDT05GSUdfQURTVFlQRSA+PSBDT05GSUdfU1lTX1BR
MkZBRFMKI3VuZGVmIENPTkZJR19TUERfRUVQUk9NCS8qIE9uIG5ldyBib2FyZHMsIFNEUkFNIGlz
IHNvbGRlcmVkICovCiNlbHNlCiNkZWZpbmUgQ09ORklHX0hBUkRfSTJDCQkxCS8qIFRvIGVuYWJs
ZSBJMkMgc3VwcG9ydAkqLwojZGVmaW5lIENPTkZJR19TWVNfSTJDX1NQRUVECQkxMDAwMDAJLyog
STJDIHNwZWVkIGFuZCBzbGF2ZSBhZGRyZXNzCSovCiNkZWZpbmUgQ09ORklHX1NZU19JMkNfU0xB
VkUJCTB4N0YKCiNpZiBkZWZpbmVkKENPTkZJR19TUERfRUVQUk9NKSAmJiAhZGVmaW5lZChDT05G
SUdfU1BEX0FERFIpCiNkZWZpbmUgQ09ORklHX1NQRF9BRERSCQkweDUwCiNlbmRpZgojZW5kaWYg
LyogQ09ORklHX0FEU1RZUEUgPj0gQ09ORklHX1NZU19QUTJGQURTICovCgovKlBDSSovCiNpZmRl
ZiBDT05GSUdfTVBDODI3MgojZGVmaW5lIENPTkZJR19QQ0kKI2RlZmluZSBDT05GSUdfUENJX1BO
UAojZGVmaW5lIENPTkZJR19QQ0lfQk9PVERFTEFZIDAKI2RlZmluZSBDT05GSUdfUENJX1NDQU5f
U0hPVwojZW5kaWYKCgovKgogKiBKRkZTMiBwYXJ0aXRpb25zCiAqCiAqIE5vdGU6IGZha2UgbXRk
X2lkIHVzZWQsIG5vIGxpbnV4IG10ZCBtYXAgZmlsZQogKi8KI2RlZmluZSBNVERJRFNfREVGQVVM
VAkJIm5vcjA9bXBjODI2MGFkcy0wIgojZGVmaW5lIE1URFBBUlRTX0RFRkFVTFQJIm10ZHBhcnRz
PW1wYzgyNjBhZHMtMDotQDFtKGpmZnMyKSIKI2RlZmluZSBDT05GSUdfU1lTX0pGRlMyX1NPUlRf
RlJBR01FTlRTCgoKLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KipNUEM4MjcyKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwov
KldlIG5lZWQgdG8gY29uZmlndXJlIGNoaXAgc2VsZWN0IHRvIHVzZSBDUExEIFBDSSBJQyBvbiBN
UEM4MjcyQURTKgoKI2lmIENPTkZJR19BRFNUWVBFID09IENPTkZJR19TWVNfODI3MkFEUwojZGVm
aW5lIENPTkZJR19TWVNfQlIzX1BSRUxJTQkoQ09ORklHX1NZU19QQ0lfSU5UIHwgMHgxODAxKQkv
KiBQQ0kgaW50ZXJydXB0IGNvbnRyb2xsZXIgKgojZGVmaW5lIENPTkZJR19TWVNfT1IzX1BSRUxJ
TQkweEZGRkY4MDEwCiNlbmRpZgoqLwoKI2lmIENPTkZJR19BRFNUWVBFID09IENPTkZJR19TWVNf
ODI3MkFEUwoKLyogUENJIE1lbW9yeSBtYXAgKGlmIGRpZmZlcmVudCBmcm9tIGRlZmF1bHQgbWFw
ICovCiNkZWZpbmUgQ09ORklHX1NZU19QQ0lfU0xWX01FTV9MT0NBTAlDT05GSUdfU1lTX1NEUkFN
X0JBU0UJCS8qIExvY2FsIGJhc2UgKi8KI2RlZmluZSBDT05GSUdfU1lTX1BDSV9TTFZfTUVNX0JV
UwkJMHgwMDAwMDAwMAkJLyogUENJIGJhc2UgKi8KI2RlZmluZSBDT05GSUdfU1lTX1BJQ01SMF9N
QVNLX0FUVFJJQgkoUElDTVJfTUFTS181MTJNQiB8IFBJQ01SX0VOQUJMRSB8IFwKCQkJCSBQSUNN
Ul9QUkVGRVRDSF9FTikKCi8qCiAqIFRoZXNlIGFyZSB0aGUgd2luZG93cyB0aGF0IGFsbG93IHRo
ZSBDUFUgdG8gYWNjZXNzIFBDSSBhZGRyZXNzIHNwYWNlLgogKiBBbGwgdGhyZWUgUENJIG1hc3Rl
ciB3aW5kb3dzLCB3aGljaCBhbGxvdyB0aGUgQ1BVIHRvIGFjY2VzcyBQQ0kKICogcHJlZmV0Y2gs
IG5vbiBwcmVmZXRjaCwgYW5kIElPIHNwYWNlIChzZWUgYmVsb3cpLCBtdXN0IGFsbCBmaXQgd2l0
aGluCiAqIHRoZXNlIHdpbmRvd3MuCiAqLwoKLyoKICogTWFzdGVyIHdpbmRvdyB0aGF0IGFsbG93
cyB0aGUgQ1BVIHRvIGFjY2VzcyBQQ0kgTWVtb3J5IChwcmVmZXRjaCkuCiAqIFRoaXMgd2luZG93
IHdpbGwgYmUgc2V0dXAgd2l0aCB0aGUgc2Vjb25kIHNldCBvZiBPdXRib3VuZCBBVFUgcmVnaXN0
ZXJzCiAqIGluIHRoZSBicmlkZ2UuCiAqLwoKI2RlZmluZSBDT05GSUdfU1lTX1BDSV9NU1RSX01F
TV9MT0NBTAkweDgwMDAwMDAwICAgICAgICAgIC8qIExvY2FsIGJhc2UgKi8KI2RlZmluZSBDT05G
SUdfU1lTX1BDSV9NU1RSX01FTV9CVVMJMHg4MDAwMDAwMCAgICAgICAgICAvKiBQQ0kgYmFzZSAg
ICovCiNkZWZpbmUJQ09ORklHX1NZU19DUFVfUENJX01FTV9TVEFSVAlQQ0lfTVNUUl9NRU1fTE9D
QUwKI2RlZmluZSBDT05GSUdfU1lTX1BDSV9NU1RSX01FTV9TSVpFCTB4MjAwMDAwMDAgICAgICAg
ICAgLyogNTEyTUIgKi8KI2RlZmluZSBDT05GSUdfU1lTX1BPQ01SMF9NQVNLX0FUVFJJQgkoUE9D
TVJfTUFTS181MTJNQiB8IFBPQ01SX0VOQUJMRSB8IFBPQ01SX1BSRUZFVENIX0VOKQoKLyoKICog
TWFzdGVyIHdpbmRvdyB0aGF0IGFsbG93cyB0aGUgQ1BVIHRvIGFjY2VzcyBQQ0kgTWVtb3J5IChu
b24tcHJlZmV0Y2gpLgogKiBUaGlzIHdpbmRvdyB3aWxsIGJlIHNldHVwIHdpdGggdGhlIHNlY29u
ZCBzZXQgb2YgT3V0Ym91bmQgQVRVIHJlZ2lzdGVycwogKiBpbiB0aGUgYnJpZGdlLgogKi8KCiNk
ZWZpbmUgQ09ORklHX1NZU19QQ0lfTVNUUl9NRU1JT19MT0NBTCAgICAweEEwMDAwMDAwICAgICAg
ICAgIC8qIExvY2FsIGJhc2UgKi8KI2RlZmluZSBDT05GSUdfU1lTX1BDSV9NU1RSX01FTUlPX0JV
UyAgICAgIDB4QTAwMDAwMDAgICAgICAgICAgLyogUENJIGJhc2UgICAqLwojZGVmaW5lIENPTkZJ
R19TWVNfQ1BVX1BDSV9NRU1JT19TVEFSVCAgICAgUENJX01TVFJfTUVNSU9fTE9DQUwKI2RlZmlu
ZSBDT05GSUdfU1lTX1BDSV9NU1RSX01FTUlPX1NJWkUgICAgIDB4MjAwMDAwMDAgICAgICAgICAg
LyogNTEyTUIgKi8KI2RlZmluZSBDT05GSUdfU1lTX1BPQ01SMV9NQVNLX0FUVFJJQiAgICAgIChQ
T0NNUl9NQVNLXzUxMk1CIHwgUE9DTVJfRU5BQkxFKQoKLyoKICogTWFzdGVyIHdpbmRvdyB0aGF0
IGFsbG93cyB0aGUgQ1BVIHRvIGFjY2VzcyBQQ0kgSU8gc3BhY2UuCiAqIFRoaXMgd2luZG93IHdp
bGwgYmUgc2V0dXAgd2l0aCB0aGUgZmlyc3Qgc2V0IG9mIE91dGJvdW5kIEFUVSByZWdpc3RlcnMK
ICogaW4gdGhlIGJyaWRnZS4KICovCgojZGVmaW5lIENPTkZJR19TWVNfUENJX01TVFJfSU9fTE9D
QUwgICAgICAgMHhGNjAwMDAwMCAgICAgICAgICAvKiBMb2NhbCBiYXNlICovCiNkZWZpbmUgQ09O
RklHX1NZU19QQ0lfTVNUUl9JT19CVVMgICAgICAgICAweDAwMDAwMDAwICAgICAgICAgIC8qIFBD
SSBiYXNlICAgKi8KI2RlZmluZSBDT05GSUdfU1lTX0NQVV9QQ0lfSU9fU1RBUlQgICAgICAgIFBD
SV9NU1RSX0lPX0xPQ0FMCiNkZWZpbmUgQ09ORklHX1NZU19QQ0lfTVNUUl9JT19TSVpFICAgICAg
ICAweDAyMDAwMDAwICAgICAgICAgIC8qIDY0TUIgKi8KI2RlZmluZSBDT05GSUdfU1lTX1BPQ01S
Ml9NQVNLX0FUVFJJQiAgICAgIChQT0NNUl9NQVNLXzMyTUIgfCBQT0NNUl9FTkFCTEUgfCBQT0NN
Ul9QQ0lfSU8pCgoKLyogUENJQlIwIC0gZm9yIFBDSSBJTyovCiNkZWZpbmUgQ09ORklHX1NZU19Q
Q0lfTVNUUjBfTE9DQUwJCUNPTkZJR19TWVNfUENJX01TVFJfSU9fTE9DQUwJCS8qIExvY2FsIGJh
c2UgKi8KI2RlZmluZSBDT05GSUdfU1lTX1BDSU1TSzBfTUFTSwkJfihDT05GSUdfU1lTX1BDSV9N
U1RSX0lPX1NJWkUgLSAxVSkJLyogU2l6ZSBvZiB3aW5kb3cgKi8KLyogUENJQlIxIC0gcHJlZmV0
Y2ggYW5kIG5vbi1wcmVmZXRjaCByZWdpb25zIGpvaW5lZCB0b2dldGhlciAqLwojZGVmaW5lIENP
TkZJR19TWVNfUENJX01TVFIxX0xPQ0FMCQlDT05GSUdfU1lTX1BDSV9NU1RSX01FTV9MT0NBTAoj
ZGVmaW5lIENPTkZJR19TWVNfUENJTVNLMV9NQVNLCQl+KENPTkZJR19TWVNfUENJX01TVFJfTUVN
X1NJWkUgKyBDT05GSUdfU1lTX1BDSV9NU1RSX01FTUlPX1NJWkUgLSAxVSkKCiNlbmRpZiAvKiBD
T05GSUdfQURTVFlQRSA9PSBDT05GSUdfODI3MkFEUyovCgojaWYgQ09ORklHX0FEU1RZUEUgPT0g
Q09ORklHX1NZU184MjcyQURTCiNkZWZpbmUgQ09ORklHX0hBU19FVEgxCiNlbmRpZgoKCiNlbmRp
ZiAvKiBfX0NPTkZJR19IICovCg==
------=_Part_21592_21580633.1247795632144--
