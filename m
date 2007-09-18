Return-Path: <mustafa.cayir@bte.mam.gov.tr>
Received: from itri.bte.mam.gov.tr (www.bte.mam.gov.tr [193.140.75.15])
	by ozlabs.org (Postfix) with SMTP id 77FF7DDE18
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Sep 2007 17:53:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7F9C8.F6A307D5"
Subject: Problem booting linux with device tree table
Date: Tue, 18 Sep 2007 10:53:13 +0300
Message-ID: <7B9A8FF57DBB524190E98CABF6E56F070B9298@itri.bte.mam.gov.tr>
From: "Mustafa Cayir" <mustafa.cayir@bte.mam.gov.tr>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7F9C8.F6A307D5
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

I am trying to boot TQM5200 with linux 2.6 kernel. i am using latest =
version of linux and u-boot from denx. And compiled with ELDK4.1=20

i use dtc compiler with following command:
dtc -O dtb -o tqm5200.dtb -b 0 tqm5200.dts

Booting process gives following error and reset the board.

WARNING: could not create /chosen FDT_ERR_NOSPACE.
ERROR: /chosen node create failed - must RESET the board to recover.

Regards.



Using FEC ETHERNET device
TFTP from server 10.18.2.83; our IP address is 10.18.5.44
Filename 'uImage'.
Load address: 0x200000
Loading: =
#################################################################
         ####################################
done
Bytes transferred =3D 1473038 (167a0e hex)
Using FEC ETHERNET device
TFTP from server 10.18.2.83; our IP address is 10.18.5.44
Filename 'tqm5200.dtb'.
Load address: 0x400000
Loading: #
done
Bytes transferred =3D 3816 (ee8 hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.23-rc6-gf695e369
   Created:      2007-09-19   1:31:43 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1472974 Bytes =3D  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using the fdt at 0x400000
WARNING: could not create /chosen FDT_ERR_NOSPACE.
ERROR: /chosen node create failed - must RESET the board to recover.





------_=_NextPart_001_01C7F9C8.F6A307D5
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DISO-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>Problem booting linux with device tree table</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi all,<BR>
<BR>
I am trying to boot TQM5200 with linux 2.6 kernel. i am using latest =
version of linux and u-boot from denx. And compiled with ELDK4.1<BR>
<BR>
i use dtc compiler with following command:<BR>
dtc -O dtb -o tqm5200.dtb -b 0 tqm5200.dts<BR>
<BR>
Booting process gives following error and reset the board.<BR>
<BR>
WARNING: could not create /chosen FDT_ERR_NOSPACE.<BR>
ERROR: /chosen node create failed - must RESET the board to recover.<BR>
<BR>
Regards.<BR>
<BR>
<BR>
<BR>
Using FEC ETHERNET device<BR>
TFTP from server 10.18.2.83; our IP address is 10.18.5.44<BR>
Filename 'uImage'.<BR>
Load address: 0x200000<BR>
Loading: =
#################################################################<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
####################################<BR>
done<BR>
Bytes transferred =3D 1473038 (167a0e hex)<BR>
Using FEC ETHERNET device<BR>
TFTP from server 10.18.2.83; our IP address is 10.18.5.44<BR>
Filename 'tqm5200.dtb'.<BR>
Load address: 0x400000<BR>
Loading: #<BR>
done<BR>
Bytes transferred =3D 3816 (ee8 hex)<BR>
## Booting image at 00200000 ...<BR>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.23-rc6-gf695e369<BR>
&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2007-09-19&nbsp;&nbsp; 1:31:43 UTC<BR>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)<BR>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1472974 Bytes =3D&nbsp; 1.4 =
MB<BR>
&nbsp;&nbsp; Load Address: 00000000<BR>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>
&nbsp;&nbsp; Verifying Checksum ... OK<BR>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>
&nbsp;&nbsp; Booting using the fdt at 0x400000<BR>
WARNING: could not create /chosen FDT_ERR_NOSPACE.<BR>
ERROR: /chosen node create failed - must RESET the board to recover.<BR>
<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7F9C8.F6A307D5--
