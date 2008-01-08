Return-Path: <jiehanca@yahoo.com.cn>
Received: from web15107.mail.cnb.yahoo.com (web15107.mail.cnb.yahoo.com
	[202.165.103.76]) by ozlabs.org (Postfix) with SMTP id 50122DDEDD
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Jan 2008 11:39:07 +1100 (EST)
Date: Mon, 7 Jan 2008 16:32:27 -0800 (PST)
From: jie han <jiehanca@yahoo.com.cn>
Subject: How to config linux kernel(ARCH=powerpc)?
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-420974133-1199752347=:77887"
Message-ID: <244511.77887.qm@web15107.mail.cnb.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-420974133-1199752347=:77887
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi everyone:

I downloaded linux kernel 2.6 from www.denx.de and unzip the kernel source code.My operation is make mrproper at first and  then make pasemi_defconfig,it didn't work,the show message as follow:

linux-2.6-denx->make mrproper

linux-2.6-denx->make pasemi_defconfig
kernel/power/Kconfig:68:warning: 'select' used by config symbol 'PM_SLEEP_SMP' refers to undefined symbol 'HOTPLUG_CPU'
***
*** Can't find default configuration "arch/ppc/configs/pasemi_defconfig"!
***
make[1]: *** [pasemi_defconfig] Error 1
make: *** [pasemi_defconfig] Error 2

 I make the other default config file under arch/powperpc/configs directory,it show the same wrong message.How can I do fix it ?Thanks ahead,

Sincerely,

Jie


       
---------------------------------
Never miss a thing.   Make Yahoo your homepage.
--0-420974133-1199752347=:77887
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi everyone:<br><br>I downloaded linux kernel 2.6 from www.denx.de and unzip the kernel source code.My operation is make mrproper at first and&nbsp; then make pasemi_defconfig,it didn't work,the show message as follow:<br><br>linux-2.6-denx-&gt;make mrproper<br><br>linux-2.6-denx-&gt;make pasemi_defconfig<br>kernel/power/Kconfig:68:warning: 'select' used by config symbol 'PM_SLEEP_SMP' refers to undefined symbol 'HOTPLUG_CPU'<br>***<br>*** Can't find default configuration "arch/ppc/configs/pasemi_defconfig"!<br>***<br>make[1]: *** [pasemi_defconfig] Error 1<br>make: *** [pasemi_defconfig] Error 2<br><br> I make the other default config file under arch/powperpc/configs directory,it show the same wrong message.How can I do fix it ?Thanks ahead,<br><br>Sincerely,<br><br>Jie<br><br><p>&#32;

      <hr size=1>Never miss a thing.  <a href="http://us.rd.yahoo.com/evt=51438/*http://www.yahoo.com/r/hs"> Make Yahoo your homepage.</a>


--0-420974133-1199752347=:77887--
