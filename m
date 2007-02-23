Return-Path: <wmaxfield@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.239])
	by ozlabs.org (Postfix) with ESMTP id A6FADDDEB9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 03:11:32 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so542961nzf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Feb 2007 08:11:30 -0800 (PST)
Message-ID: <45a1b53e0702230811i79bbc10dqd6e10ac05b06ac16@mail.gmail.com>
Date: Fri, 23 Feb 2007 10:11:28 -0600
From: "Wade Maxfield" <wmaxfield@gmail.com>
To: ppc <linuxppc-embedded@ozlabs.org>
Subject: debugging custom Xilinx boot loader with abatron and Montavista
	devrocket
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_57395_9451243.1172247088384"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_57395_9451243.1172247088384
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

  I want to debug a ppc custom boot loader with Montavista (since we spent
the money on it) under the Xilinx fx60.

  I've been able to get the kernel to debug under MontaVista.  However,
since the hardware engineers have given up on DDR ram (they could not get it
to work reliably and will be dropping it from the next release), I don't
think I can use Linux for now.   Unfortunately, this decision is not
changeable.  When a hardware engineer is embarrassed, the results are not
good for software engineers.

I don't think I've got enough static ram to host a PPC linux kernel and
applications (we only have 8 meg).  We will have 16 meg on the next release,
I expect.  Is that enough for simple apps and linux under PPC???  I need
some guidance here, as I don't have enough PPC experience.

  Fortunately, we got the ppc running and can manage the hardware using
Xilkernel and Xilnet (lwIP maybe later).

  I've done numerous Google searches, and searches on MontaVista support
page.  They are specific to Linux.

  Has anyone debugged a custom boot loader with MontaVista and Abatron?  How
do you set up the project under  eclipse (which is devrocket)?  Nothing I
see seems to match, as I need the boot vector code, and I don't know how to
tell eclipse to compile for that option.  Can I just bring over the elf
(compiled with debug under Xilinx) and the source files and start
debugging?  If so, what kind of project would I pick under devrocket?  The
more I look, the more confused I get.

   I could possibly bring up linux on an ML403 board and use gdb/ddd on
that.  if so, how would I cause the boot code to be located at the right
address?  Any howto's to read that aren't simply hand waves would be very
useful. I understand once I do it is easy, but getting it done the first
time is my problem right now.

   I've got to pull some serious asses from the fire, so I'm under a lot of
pressure.  I also know who will be blamed if I don't pull this off.

  Any help is greatly appreciated!

thanks,
wade

------=_Part_57395_9451243.1172247088384
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>&nbsp; I want to debug a ppc custom boot loader with Montavista (since we spent the money on it) under the Xilinx fx60.<br><br>&nbsp; I&#39;ve been able to get the kernel to debug under MontaVista.&nbsp; However, since the hardware engineers have given up on DDR ram (they could not get it to work reliably and will be dropping it from the next release), I don&#39;t think I can use Linux for now. &nbsp; Unfortunately, this decision is not changeable.&nbsp; When a hardware engineer is embarrassed, the results are not good for software engineers.
<br><br>I don&#39;t think I&#39;ve got enough static ram to host a PPC linux kernel and applications (we only have 8 meg).&nbsp; We will have 16 meg on the next release, I expect.&nbsp; Is that enough for simple apps and linux under PPC???&nbsp; I need some guidance here, as I don&#39;t have enough PPC experience.
<br><br>&nbsp; Fortunately, we got the ppc running and can manage the hardware using Xilkernel and Xilnet (lwIP maybe later).<br><br>&nbsp; I&#39;ve done numerous Google searches, and searches on MontaVista support page.&nbsp; They are specific to Linux.
<br><br>&nbsp; Has anyone debugged a custom boot loader with MontaVista and Abatron?&nbsp; How do you set up the project under&nbsp; eclipse (which is devrocket)?&nbsp; Nothing I see seems to match, as I need the boot vector code, and I don&#39;t know how to tell eclipse to compile for that option.&nbsp; Can I just bring over the elf (compiled with debug under Xilinx) and the source files and start debugging?&nbsp; If so, what kind of project would I pick under devrocket?&nbsp; The more I look, the more confused I get.
<br><br>&nbsp;&nbsp; I could possibly bring up linux on an ML403 board and use gdb/ddd on that.&nbsp; if so, how would I cause the boot code to be located at the right address?&nbsp; Any howto&#39;s to read that aren&#39;t simply hand waves would be very useful. I understand once I do it is easy, but getting it done the first time is my problem right now.
<br><br>&nbsp;&nbsp; I&#39;ve got to pull some serious asses from the fire, so I&#39;m under a lot of pressure.&nbsp; I also know who will be blamed if I don&#39;t pull this off.<br><br>&nbsp; Any help is greatly appreciated!<br><br>thanks,<br>
wade<br>

------=_Part_57395_9451243.1172247088384--
