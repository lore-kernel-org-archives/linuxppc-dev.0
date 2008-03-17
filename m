Return-Path: <Andre.Schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 83D17DDE24
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 20:35:47 +1100 (EST)
Message-ID: <47DE3B79.90205@matrix-vision.de>
Date: Mon, 17 Mar 2008 10:35:53 +0100
From: =?ISO-8859-1?Q?Andr=E9_Schwarz?= <Andre.Schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: simple MPC5200B system
References: <47DD71D0.2010203@matrix-vision.de>
	<fa686aa40803161301r1685f2cale75d67b8a203cca3@mail.gmail.com>
In-Reply-To: <fa686aa40803161301r1685f2cale75d67b8a203cca3@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------080509080407090105040002"
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080509080407090105040002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Grant Likely wrote:
> On Sun, Mar 16, 2008 at 1:15 PM, Andr=E9 Schwarz
> <Andre.Schwarz@matrix-vision.de> wrote:
>  =20
>> All,
>>
>>  I'm quite stuck in getting our MPC5200B based systems work on 2.6.24+
>>  ... maybe someone could give me some hints.
>>  Up to now the systems have been running on 2.6.19 without any problem=
s.
>>
>>  This is what I've done so far :
>>
>>  - get a recent system with 2.6.19 running and keep the toolchain (gcc
>>  4.0) including RFS uImage.
>>  - latest bootloader (u-boot 1.3.2) is running fine with dtb support.
>>  - Kernel and RFS images are available via bootp/tftp
>>  - device tree blob seems ok, i.e. u-boot can display the blob and fil=
l
>>  in all clocks correctly.
>>  - Kernel gets called with Kernel, RFS and dtb on suitable adresses
>>  (0x100000, 0x600000, 0x5F0000).
>>  - nothing more happens. It looks like the console isn't working prope=
rly
>>  - maybe worse ...
>>    =20
>
> Can you either halt the processor or reset the board and access memory
> after this point?  You should see if you can access __log_buf (Look in
> System.map for the address and subtract 0xc0000000 to get the physical
> address).   __log_buf should give you clues about how far booting
> progresses.
>
>  =20
As soon as my abatron debugger is back I'll give it a try - currently=20
it's out for an update ...
Are there any restrictions for the memory locations of the kernel,=20
initrd and dtb images ?

Thanks for the help. I'll post the __log_buf tomorrow ... propably.

>>  The kernel has been build using the "MPC5200 simple" setup. I've adde=
d
>>  our board identifier "mv,mvbluecougar" to the list of supported board=
s
>>  in the "mpc52xx_simple.c" file. This identifier is used in the dtb as
>>  well of course. This should be enough along with a valid device tree
>>  blob, isn't it ? Did I miss anything already ?
>>    =20
>
> Yes, this should be enough (on a side note; it should probably be
> "matrix-vision,bluecougar" unless of''mv' is your company's stock
> ticker symbol).
>
>  =20
>>  As far as I did understand by reading the docs it should be possible
>>  running a general MPC52xx kernel with a custom dtb ? Is this correct =
?
>>    =20
>
> That is correct.
>
>  =20
>>  The dts file has already been reduced to a minimum, i.e. only the cpu=
,
>>  pic, xlb and a few nodes like psc1 and psc2 are present. No bestcomm,
>>  pci, ata or "advanced" features like mtd partitions. All I want to ge=
t
>>  working is the serial console on "/dev/ttyPSC0".
>>    =20
>
> Cheers,
> g.
>
>  =20
regards,
Andr=E9


MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht: Amtsgericht Stuttgart, HRB 271090
Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner

--------------080509080407090105040002
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Grant Likely wrote:
<blockquote
 cite="mid:fa686aa40803161301r1685f2cale75d67b8a203cca3@mail.gmail.com"
 type="cite">
  <pre wrap="">On Sun, Mar 16, 2008 at 1:15 PM, Andr&eacute; Schwarz
<a class="moz-txt-link-rfc2396E" href="mailto:Andre.Schwarz@matrix-vision.de">&lt;Andre.Schwarz@matrix-vision.de&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">All,

 I'm quite stuck in getting our MPC5200B based systems work on 2.6.24+
 ... maybe someone could give me some hints.
 Up to now the systems have been running on 2.6.19 without any problems.

 This is what I've done so far :

 - get a recent system with 2.6.19 running and keep the toolchain (gcc
 4.0) including RFS uImage.
 - latest bootloader (u-boot 1.3.2) is running fine with dtb support.
 - Kernel and RFS images are available via bootp/tftp
 - device tree blob seems ok, i.e. u-boot can display the blob and fill
 in all clocks correctly.
 - Kernel gets called with Kernel, RFS and dtb on suitable adresses
 (0x100000, 0x600000, 0x5F0000).
 - nothing more happens. It looks like the console isn't working properly
 - maybe worse ...
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Can you either halt the processor or reset the board and access memory
after this point?  You should see if you can access __log_buf (Look in
System.map for the address and subtract 0xc0000000 to get the physical
address).   __log_buf should give you clues about how far booting
progresses.

  </pre>
</blockquote>
As soon as my abatron debugger is back I'll give it a try - currently
it's out for an update ...<br>
Are there any restrictions for the memory locations of the kernel,
initrd and dtb images ? <br>
<br>
Thanks for the help. I'll post the __log_buf tomorrow ... propably.<br>
<br>
<blockquote
 cite="mid:fa686aa40803161301r1685f2cale75d67b8a203cca3@mail.gmail.com"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap=""> The kernel has been build using the "MPC5200 simple" setup. I've added
 our board identifier "mv,mvbluecougar" to the list of supported boards
 in the "mpc52xx_simple.c" file. This identifier is used in the dtb as
 well of course. This should be enough along with a valid device tree
 blob, isn't it ? Did I miss anything already ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Yes, this should be enough (on a side note; it should probably be
"matrix-vision,bluecougar" unless of''mv' is your company's stock
ticker symbol).

  </pre>
  <blockquote type="cite">
    <pre wrap=""> As far as I did understand by reading the docs it should be possible
 running a general MPC52xx kernel with a custom dtb ? Is this correct ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
That is correct.

  </pre>
  <blockquote type="cite">
    <pre wrap=""> The dts file has already been reduced to a minimum, i.e. only the cpu,
 pic, xlb and a few nodes like psc1 and psc2 are present. No bestcomm,
 pci, ata or "advanced" features like mtd partitions. All I want to get
 working is the serial console on "/dev/ttyPSC0".
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Cheers,
g.

  </pre>
</blockquote>
regards,<br>
Andr&eacute;<br>
<BR>

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
<BR>
</body>
</html>

--------------080509080407090105040002--
