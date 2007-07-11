Return-Path: <kkboyanov@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.231])
	by ozlabs.org (Postfix) with ESMTP id 47E54DDED0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jul 2007 00:50:34 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so1374742wxd
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 07:50:33 -0700 (PDT)
Message-ID: <929bf310707110750r32557735v848d84c626f0b5d9@mail.gmail.com>
Date: Wed, 11 Jul 2007 16:50:32 +0200
From: "Konstantin Boyanov" <kkboyanov@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Leaf drivers on Linux?
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3531_1456567.1184165432893"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_3531_1456567.1184165432893
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi list,

I'm a little bit confused about an issue I hope you can shed some light on
it.

Right now I'm trying to write a driver for a vustom piece of hardware, which
resides on a VME bus. I'm using 2.6.15 kernel with an VME driver and can
access the device through normal ioctl()'s, read(), writes()'s. My
confiusion comes from the fact that from my driver I have to read some
registers when the custom device generates an interrupt, but since this
happens in kernel space, I'm not sure wheather I can use the normal IO
controls or not. Further confusion brings the fact that there is already a
working device for Solaris/SPARC for this device, and there the device
driver uses some kind of leaf driver. Is the concept of leaf and nexus
drivers, which is present in Solaris, also present in Linux? I tried to find
some information about differences in the two operating systems on that
level but only ended up in the "Writing device drivers" tutorials on
doc.sun.com.

If anybody can give me some clue about this leaf stuff I'll be thankful.

Best regards,
Konstantin

------=_Part_3531_1456567.1184165432893
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi list,<br><br>I&#39;m a little bit confused about an issue I hope you can shed some light on it.<br><br>Right now I&#39;m trying to write a driver for a vustom piece of hardware, which resides on a VME bus. I&#39;m using 
2.6.15 kernel with an VME driver and can access the device through normal ioctl()&#39;s, read(), writes()&#39;s. My confiusion comes from the fact that from my driver I have to read some registers when the custom device generates an interrupt, but since this happens in kernel space, I&#39;m not sure wheather I can use the normal IO controls or not. Further confusion brings the fact that there is already a working device for Solaris/SPARC for this device, and there the device driver uses some kind of leaf driver. Is the concept of leaf and nexus drivers, which is present in Solaris, also present in Linux? I tried to find some information about differences in the two operating systems on that level but only ended up in the &quot;Writing device drivers&quot; tutorials on 
<a href="http://doc.sun.com">doc.sun.com</a>.<br><br>If anybody can give me some clue about this leaf stuff I&#39;ll be thankful.<br><br>Best regards,<br>Konstantin<br><br>

------=_Part_3531_1456567.1184165432893--
