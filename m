Return-Path: <skrishnakar@gmail.com>
Message-ID: <6213bc560711282323v20c245fewf4f8390c5591d681@mail.gmail.com>
Date: Thu, 29 Nov 2007 12:53:19 +0530
From: "srikanth krishnakar" <skrishnakar@gmail.com>
To: Linuxppc-embedded@ozlabs.org
Subject: SCC QMC driver Compilation
In-Reply-To: <6213bc560711282312t6e504846hceb81162e63310c9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_9877_12266683.1196320999868"
References: <6213bc560711282312t6e504846hceb81162e63310c9@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_9877_12266683.1196320999868
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi panto,

Good Day,

I am trying to compile the QMC driver given for 2.4 kernel. but I am getting
the IOCTL errors. Will you please let me know the solution for these.

* Below is the log of Errors generated while compilation:**

*ppc_8xx-gcc -D__KERNEL__ -I/home/TEST_QMC/linux- 2.4.20_mvl31/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -I/home/TEST_QMC/linux-
2.4.20_mvl31/arch/ppc-fsigned-char -msoft-float -pipe -ffixed-r2
-Wno-uninitialized -mmultiple
-mstring   -nostdinc -iwithprefix include -DKBUILD_BASENAME=qmc_core
-DEXPORT_SYMTAB -c qmc-core.c
qmc-core.c: In function `qmc_ioctl':
qmc-core.c:456: error: `QMC_IOC_MAGIC' undeclared (first use in this
function)
qmc-core.c:456: error: (Each undeclared identifier is reported only once
qmc-core.c:456: error: for each function it appears in.)
qmc-core.c:458: error: `QMC_IOC_MAXNR' undeclared (first use in this
function)
qmc-core.c:466: error: `QMC_IOCRESET' undeclared (first use in this
function)
qmc-core.c:469: error: `QMC_IOCSCONF' undeclared (first use in this
function)
qmc-core.c:470: error: `QMC_IOCGCONF' undeclared (first use in this
function)
qmc-core.c:471: error: storage size of `req' isn't known
qmc-core.c:471: warning: unused variable `req'
qmc-core.c :1012:2: #error Unknown board configuration.
qmc-core.c: In function `qmc_setup':
qmc-core.c:1311: error: `CLK_PCM_BIT' undeclared (first use in this
function)
qmc-core.c:1311: error: `X_PCMOUT1_BIT' undeclared (first use in this
function)
qmc-core.c:1311: error: `X_PCMIN1_BIT' undeclared (first use in this
function)
qmc-core.c:1313: error: `PCM_FS_BIT' undeclared (first use in this function)
qmc-core.c: In function `qmc_cleanup':
qmc-core.c :1640: error: `CLK_PCM_BIT' undeclared (first use in this
function)
qmc-core.c:1640: error: `X_PCMOUT1_BIT' undeclared (first use in this
function)
qmc-core.c:1640: error: `X_PCMIN1_BIT' undeclared (first use in this
function)
qmc-core.c: In function `devices_init':
qmc-core.c:1662: error: `QMC_MAJOR' undeclared (first use in this function)
qmc-core.c: In function `devices_cleanup':
qmc-core.c:1684: error: `QMC_MAJOR' undeclared (first use in this function)
make[3]: *** [qmc-core.o] Error 1
make[3]: Leaving directory `/home/TEST_QMC/linux-2.4.20_mvl31/drivers/qmc'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/home/TEST_QMC/linux-2.4.20_mvl31/drivers/qmc '
make[1]: *** [_subdir_qmc] Error 2
make[1]: Leaving directory `/home/TEST_QMC/linux-2.4.20_mvl31/drivers'
make: *** [_dir_drivers] Error 2
[root@smk linux-2.4.20_mvl31]# vi drivers/qmc/qmc-core.c  +456 *

*
Waiting for your reply.



-- 
"The Good You Do, The Best You GET"

Regards
Srikanth Krishnakar
**********************



-- 
"The Good You Do, The Best You GET"

Regards
Srikanth Krishnakar
**********************

------=_Part_9877_12266683.1196320999868
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div class="gmail_quote"><br>Hi panto,<br><br>Good Day,<br><br>I am trying to compile the QMC driver
given for 2.4 kernel. but I am getting the IOCTL errors. Will you
please let me know the solution for these.<br><br><b>
<span style="font-family: times new roman,serif;"><font size="4">
Below is the log of Errors generated while compilation:</font></span></b><i><span style="font-family: times new roman,serif;"><br><br></span></i><span style="font-family: times new roman,serif;">ppc_8xx-gcc
-D__KERNEL__ -I/home/TEST_QMC/linux-
2.4.20_mvl31/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -fomit-frame-pointer
-I/home/TEST_QMC/linux-
2.4.20_mvl31/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2
-Wno-uninitialized -mmultiple -mstring&nbsp;&nbsp; -nostdinc -iwithprefix include
-DKBUILD_BASENAME=qmc_core&nbsp; -DEXPORT_SYMTAB -c qmc-core.c<br>qmc-core.c: In function `qmc_ioctl&#39;:
<br>qmc-core.c:456: error: `QMC_IOC_MAGIC&#39; undeclared (first use in this function)<br>qmc-core.c:456: error: (Each undeclared identifier is reported only once<br>qmc-core.c:456: error: for each function it appears in.)
<br>qmc-core.c:458: error: `QMC_IOC_MAXNR&#39; undeclared (first use in this function)<br>qmc-core.c:466: error: `QMC_IOCRESET&#39; undeclared (first use in this function)<br>qmc-core.c:469: error: `QMC_IOCSCONF&#39; undeclared (first use in this function)
<br>qmc-core.c:470: error: `QMC_IOCGCONF&#39; undeclared (first use in this function)<br>qmc-core.c:471: error: storage size of `req&#39; isn&#39;t known<br>qmc-core.c:471: warning: unused variable `req&#39;<br>qmc-core.c



:1012:2: #error Unknown board configuration.<br>qmc-core.c: In function `qmc_setup&#39;:<br>qmc-core.c:1311: error: `CLK_PCM_BIT&#39; undeclared (first use in this function)<br>qmc-core.c:1311: error: `X_PCMOUT1_BIT&#39; undeclared (first use in this function)
<br>qmc-core.c:1311: error: `X_PCMIN1_BIT&#39; undeclared (first use in this function)<br>qmc-core.c:1313: error: `PCM_FS_BIT&#39; undeclared (first use in this function)<br>qmc-core.c: In function `qmc_cleanup&#39;:<br>


qmc-core.c
:1640: error: `CLK_PCM_BIT&#39; undeclared (first use in this function)<br>qmc-core.c:1640: error: `X_PCMOUT1_BIT&#39; undeclared (first use in this function)<br>qmc-core.c:1640: error: `X_PCMIN1_BIT&#39; undeclared (first use in this function)
<br>qmc-core.c: In function `devices_init&#39;:<br>qmc-core.c:1662: error: `QMC_MAJOR&#39; undeclared (first use in this function)<br>qmc-core.c: In function `devices_cleanup&#39;:<br>qmc-core.c:1684: error: `QMC_MAJOR&#39; undeclared (first use in this function)
<br>make[3]: *** [qmc-core.o] Error 1<br>make[3]: Leaving directory `/home/TEST_QMC/linux-2.4.20_mvl31/drivers/qmc&#39;<br>make[2]: *** [first_rule] Error 2<br>make[2]: Leaving directory `/home/TEST_QMC/linux-2.4.20_mvl31/drivers/qmc



&#39;<br>make[1]: *** [_subdir_qmc] Error 2<br>make[1]: Leaving directory `/home/TEST_QMC/linux-2.4.20_mvl31/drivers&#39;<br>make: *** [_dir_drivers] Error 2<br>[root@smk linux-2.4.20_mvl31]# vi drivers/qmc/qmc-core.c&nbsp; +456
</span><i><span style="font-family: times new roman,serif;"><br><br></span></i><br>Waiting for your reply. <br clear="all"><font color="#888888"><font color="#888888"><br></font><br clear="all"><br>-- <br>&quot;The Good You Do, The Best You GET&quot;
<br><br>Regards<br>Srikanth Krishnakar<br>**********************
</font></div><br><br clear="all"><br>-- <br>&quot;The Good You Do, The Best You GET&quot;<br><br>Regards<br>Srikanth Krishnakar<br>**********************

------=_Part_9877_12266683.1196320999868--
