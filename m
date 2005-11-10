Return-Path: <nitesh.guinde@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.192])
	by ozlabs.org (Postfix) with ESMTP id F285C686AD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 16:04:19 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id i27so486009wxd
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 09 Nov 2005 21:04:18 -0800 (PST)
Message-ID: <4fb800d20511092057x47622b95vca0153c069ac97e@mail.gmail.com>
Date: Wed, 9 Nov 2005 23:57:39 -0500
From: Nitesh Guinde <nitesh.guinde@gmail.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_19927_28560746.1131598659770"
Subject: "Now booting the kernel"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_19927_28560746.1131598659770
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello all,
I am loading a linux kernel onto ML310 board .I want networking support and
hence I have a pci enabled design.
I am using linux 2.4 powerpc devel kernel. I have also tried the montavista
previewkit
But I end up with the same problem. I have enabled the option " support for
early boot texts: in the kernel debugging.
Now once run the kernel program in powerpc I get the following essages in
the serial minicom terminal
Enter Desired System ACE CF Configuration <0-7>.
0: ACE-loader.
1: Linux w/PCI.
2: VxWorks w/PCI.
3: QNX Demo.
4: Linux EDK Base Build.
5: VxWorks EDK Base Build.
6: User Configuration A.
7: User Configuration B.


Select:
loaded at: 00400000 008CB1E0
board data at: 008C8138 008C8150
relocated to: 00405308 00405320
zimage at: 00405813 004DE42A
initrd at: 004DF000 008C7382
avail ram: 008CC000 10000000


Linux/PPC load: console=3DttyS0,9600 root=3D/dev/xsysace/disc0/part2 rw
Uncompressing Linux...done.
Now booting the kernel


The prompt goes dead at this point.The board details is available at
www.xilinx.com/ml310 <http://www.xilinx.com/ml310>

Any workarounds?

Thanks,

Nitesh

------=_Part_19927_28560746.1131598659770
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<p>Hello all,<br>I am loading a linux kernel onto ML310 board .I want netwo=
rking support and hence I have a pci enabled design.<br>I am using linux 2.=
4 powerpc devel kernel. I have also tried the montavista previewkit<br>But =
I end up with the same problem. I have enabled the option &quot; support fo=
r early boot texts: in the kernel debugging.
<br>Now once run the kernel program in powerpc I get the following essages =
in the serial minicom terminal<br>Enter Desired System ACE CF Configuration=
 &lt;0-7&gt;. <br>&nbsp;&nbsp; 0: ACE-loader. <br>&nbsp;&nbsp; 1: Linux w/P=
CI. <br>&nbsp;&nbsp; 2: VxWorks w/PCI.=20
<br>&nbsp;&nbsp; 3: QNX Demo. <br>&nbsp;&nbsp; 4: Linux EDK Base Build. <br=
>&nbsp;&nbsp; 5: VxWorks EDK Base Build. <br>&nbsp;&nbsp; 6: User Configura=
tion A. <br>&nbsp;&nbsp; 7: User Configuration B. </p>
<p><br>Select: <br>loaded at:&nbsp;&nbsp;&nbsp;&nbsp; 00400000 008CB1E0 <br=
>board data at: 008C8138 008C8150 <br>relocated to:&nbsp; 00405308 00405320=
 <br>zimage at:&nbsp;&nbsp;&nbsp;&nbsp; 00405813 004DE42A <br>initrd at:&nb=
sp;&nbsp;&nbsp;&nbsp; 004DF000 008C7382 <br>avail ram:&nbsp;&nbsp;&nbsp;&nb=
sp; 008CC000 10000000=20
</p>
<p><br>Linux/PPC load: console=3DttyS0,9600 root=3D/dev/xsysace/disc0/part2=
 rw <br>Uncompressing Linux...done. <br>Now booting the kernel </p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p><br>The prompt goes dead at this point.The board details is available at=
 <a href=3D"http://www.xilinx.com/ml310">www.xilinx.com/ml310</a></p>
<p>Any workarounds?</p>
<p>Thanks,</p>
<p>Nitesh</p>

------=_Part_19927_28560746.1131598659770--
