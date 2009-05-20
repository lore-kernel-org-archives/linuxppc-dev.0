Return-Path: <xuemingmin@126.com>
Received: from m15-28.126.com (m15-28.126.com [220.181.15.28])
	by ozlabs.org (Postfix) with SMTP id 8B11CDE11E
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 01:16:27 +1000 (EST)
Date: Wed, 20 May 2009 22:44:48 +0800 (CST)
From: xuemingmin <xuemingmin@126.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <6825098.918711242830688677.JavaMail.coremail@bj126app28.126.com>
Subject: Linux pcf8574 driver based MPC8349EA
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_245322_25644880.1242830688675"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_245322_25644880.1242830688675
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

Recently , I'm busy with a project based on the main board - MPC8349EA. We use a pcf8574 connected I2C bus. Now my task is programming to test I2C bus. I find that file system contains the chip(pcf8574) module .And I add this module into the kernel. But I find that system only registers the driver,not device.And I can not get the device's major and minor device number. Therefore, I can not create the device file to operate the device.
My question:
 How can I use the device which is not registered in the system,or can you provide some advices to complete the task.


 
------=_Part_245322_25644880.1242830688675
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<DIV>Recently , I'm busy with a project based on the main board - MPC8349EA=
 We use a pcf8574 connected I2C bus. Now my task is programming to test I2=
C bus. I find that file system contains the chip(pcf8574) module .And I add=
 this module into the kernel. But I find that system only registers the dri=
ver,not device.And I can not get the device's major and minor device number=
&nbsp;Therefore, I can not create the device file to operate the device.<B=
R>My question:<BR>&nbsp;How can I use the device which is not registered in=
 the system,or can you provide some advices to complete the task.</DIV>
<DIV><BR><BR>&nbsp;</DIV><br><!-- footer --><br><span title=3D"neteasefoote=
r"/><hr/>
<a href=3D"http://512.mail.163.com/mailstamp/stamp/dz/activity.do?from=3Dfo=
oter">=B4=A9=D4=BD=B5=D8=D5=F0=B4=F8 =BC=CD=C4=EE=E3=EB=B4=A8=B5=D8=D5=F0=
=D2=BB=D6=DC=C4=EA</a>
</span>
------=_Part_245322_25644880.1242830688675--
