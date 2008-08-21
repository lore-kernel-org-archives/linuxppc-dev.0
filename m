Return-Path: <lk.atwork@yahoo.com>
Received: from n78.bullet.mail.sp1.yahoo.com (n78.bullet.mail.sp1.yahoo.com
	[98.136.44.42]) by ozlabs.org (Postfix) with SMTP id 689AFDE7BB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Aug 2008 07:12:16 +1000 (EST)
Date: Thu, 21 Aug 2008 14:12:15 -0700 (PDT)
From: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Subject: Re: porting linux 2.6.27 to embedded powerpc board
To: Scott Wood <scottwood@freescale.com>,
	David Jander <david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-701845607-1219353135=:22152"
Message-ID: <750378.22152.qm@web46310.mail.sp1.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-701845607-1219353135=:22152
Content-Type: text/plain; charset=us-ascii

Just wanted to thank all of you for the detailed feedback and suggestions.
I am going to try them out now and keep my fingers crossed.

thanks again
LK



----- Original Message ----
From: Scott Wood <scottwood@freescale.com>
To: David Jander <david.jander@protonic.nl>
Cc: linuxppc-embedded@ozlabs.org; Laxmikant Rashinkar <lk.atwork@yahoo.com>
Sent: Thursday, August 21, 2008 9:12:23 AM
Subject: Re: porting linux 2.6.27 to embedded powerpc board

David Jander wrote:
> 4. Be sure that the device(s) necessary to produce output on your console are 
> correctly placed in the DT. Also make sure that u-boot knows about it 
> (#define OF_STDOUT_PATH... in your u-boot board config file)

OF_STDOUT_PATH is deprecated; you should enable 
CONFIG_OF_SERIAL_VIA_ALIAS, and provide aliases in the device tree for 
serial0, serial1, etc.

> 6. Remember to always specify the "rootfstype=" option on the commandline if 
> booting from anything other than NFS. This was not necessary back in the 
> 2.6.15-times AFAICR.

It still should not be necessary.

> 7. Boot with a device-tree (in u-boot: "bootm $addrofkernel - $addrofdtb", 
> don't forget the dash if you are not using an initrd). If you don't do this, 
> u-boot can't fix your DT, and the kernel probably won't find it either.

s/probably/definitely/

> 8. Be sure to use the correct version of the DTC (DT compiler) for your kernel 
> (the sources are included nowadays, somewhere in arch/powerpc/boot IIRC). The 
> command used to compile, should probably be something like this:

Or just use the most recent DTC.

-Scott


      
--0-701845607-1219353135=:22152
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><div>Just wanted to thank all of you for the detailed feedback and suggestions.<br>I am going to try them out now and keep my fingers crossed.<br><br>thanks again<br>LK<br></div><div style="font-family: times new roman,new york,times,serif; font-size: 12pt;"><br><div style="font-family: arial,helvetica,sans-serif; font-size: 13px;">----- Original Message ----<br>From: Scott Wood &lt;scottwood@freescale.com&gt;<br>To: David Jander &lt;david.jander@protonic.nl&gt;<br>Cc: linuxppc-embedded@ozlabs.org; Laxmikant Rashinkar &lt;lk.atwork@yahoo.com&gt;<br>Sent: Thursday, August 21, 2008 9:12:23 AM<br>Subject: Re: porting linux 2.6.27 to embedded powerpc board<br><br>
David Jander wrote:<br>&gt; 4. Be sure that the device(s) necessary to produce output on your console are <br>&gt; correctly placed in the DT. Also make sure that u-boot knows about it <br>&gt; (#define OF_STDOUT_PATH... in your u-boot board config file)<br><br>OF_STDOUT_PATH is deprecated; you should enable <br>CONFIG_OF_SERIAL_VIA_ALIAS, and provide aliases in the device tree for <br>serial0, serial1, etc.<br><br>&gt; 6. Remember to always specify the "rootfstype=" option on the commandline if <br>&gt; booting from anything other than NFS. This was not necessary back in the <br>&gt; 2.6.15-times AFAICR.<br><br>It still should not be necessary.<br><br>&gt; 7. Boot with a device-tree (in u-boot: "bootm $addrofkernel - $addrofdtb", <br>&gt; don't forget the dash if you are not using an initrd). If you don't do this, <br>&gt; u-boot can't fix your DT, and the kernel probably won't find it either.<br><br>s/probably/definitely/<br><br>&gt; 8. Be sure to use
 the correct version of the DTC (DT compiler) for your kernel <br>&gt; (the sources are included nowadays, somewhere in arch/powerpc/boot IIRC). The <br>&gt; command used to compile, should probably be something like this:<br><br>Or just use the most recent DTC.<br><br>-Scott<br><br></div></div></div><br>



      </body></html>
--0-701845607-1219353135=:22152--
