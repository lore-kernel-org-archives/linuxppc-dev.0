Return-Path: <umeshdelhi@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id C7898474C2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Dec 2008 23:20:58 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1225626ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Dec 2008 04:20:57 -0800 (PST)
Message-ID: <9c4da51b0812160420r223a294j3bbe481c8b1b81fa@mail.gmail.com>
Date: Tue, 16 Dec 2008 17:50:57 +0530
From: "umesh krishnan" <umeshdelhi@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: how to make a PowerPC executable??
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_50731_5626720.1229430057381"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_50731_5626720.1229430057381
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi group,

I have a little problem out here. I have some codes with me which i have to
run on PowerPC based target. I dont have that particular hardware with me.
Can anyone suggest a cross-compiler or an emulator, so that i can compile my
codes in linux and make a PowerPC executable from here. I tried qemu but it
didn't work.

It was making a 386 executable rather than a powerpc executable. The cross
compiler option 'powerpc-750-unknown-gnu-gcc' was not coming.. Instead it
was to build a 386 based executable. I did everything following the
"Emulation and cross-development for PowerPC" page in the link
http://www.ibm.com/developerworks/library/pa-emulation.html ..
qemu-ppc emulator was installed correctly but the crosstool was the problem.
Please help me out. I cant afford a VxWorks (For the workbench or the
Tornado compiler). Any way out..
Can i sit on windows and do something? Is there any emulator like that?
I'm fairly new to this field. Kindly guide me through..


Any help in this regard is most welcome.

Thanks in advance,
Umesh.

------=_Part_50731_5626720.1229430057381
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi group,<br>
<br>
I have a little problem out here. I have some codes with me which i
have to run on PowerPC based target. I dont have that particular
hardware with me. Can anyone suggest a cross-compiler or an emulator,
so that i can compile my codes in linux and make a PowerPC executable
from here. I tried qemu but it didn&#39;t work. <br><br>It was making a 386 executable rather than a powerpc executable. The cross compiler option &#39;powerpc-750-unknown-gnu-gcc&#39; was not coming.. Instead it was to build a 386 based executable. I did everything following the &quot;Emulation and cross-development for PowerPC&quot; page in the link <a href="http://www.ibm.com/developerworks/library/pa-emulation.html">http://www.ibm.com/developerworks/library/pa-emulation.html</a> ..<br>
qemu-ppc emulator was installed correctly but the crosstool was the problem.<br>Please help me out. I cant afford a VxWorks (For the workbench or the Tornado compiler). Any way out..<br>Can i sit on windows and do something? Is there any emulator like that?<br>
I&#39;m fairly new to this field. Kindly guide me through..<br><br><br>Any help in this regard is
most welcome.<br>
<br>
Thanks in advance,<br>
Umesh.<br>

------=_Part_50731_5626720.1229430057381--
