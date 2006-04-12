Return-Path: <saiprasannasp@yahoo.com>
Received: from web54313.mail.yahoo.com (web54313.mail.yahoo.com
	[206.190.49.123]) by ozlabs.org (Postfix) with SMTP id F269F67B9B
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 17:44:56 +1000 (EST)
Message-ID: <20060412073814.39382.qmail@web54313.mail.yahoo.com>
Date: Wed, 12 Apr 2006 00:38:14 -0700 (PDT)
From: Sai prasanna <saiprasannasp@yahoo.com>
Subject: BFD 2.16.1 assertion fail
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2131947936-1144827494=:39064"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-2131947936-1144827494=:39064
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


 Date: Wed, 12 Apr 2006 00:04:59 -0700 (PDT)
From: Sai prasanna <saiprasannasp@yahoo.com>
Subject: BFD 2.16.1 assertion fail
To: linux project group <linux_projects_2006@yahoogroups.com>
CC: saiprasannasp@yahoo.com

 Hi All,

I Have been trying to build across compiler for power-ppc-linux-gnu I have succesfully installed binutils-2.16.1, first phase gcc-4.0.3, glibc-2.3.6 and then when i finally tried to install the final gcc ima getting eror such as

/home/foo/build-install/powerpc-ppc-linux-gnu/bin/ld: BFD 2.16.1 assertion fail../../binutils-2.16.1/bfd/elf32-ppc.c:5397
collect2: ld returned 1 exit status
make[3]: *** [libmudflap.la] Error 1
make[3]: Leaving directory `/home/foo/build-gcc/powerpc-ppc-linux-gnu/libmudflap'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/foo/build-gcc/powerpc-ppc-linux-gnu/libmudflap'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/foo/build-gcc/powerpc-ppc-linux-gnu/libmudflap'
make: *** [all-target-libmudflap] Error 2

I have used the following gcc configuration opitons

[root@localhost build-gcc]# ../gcc-4.0.3/configure --host=i686-pc-linux-gnu  --target=powerpc-ppc-linux-gnu --prefix=/home/foo/build-install --enable-languages=c,c++ 

Some one please help me with this.

Regards,
Sai      


Sai Prasanna.S,
Department Of ComputerScience,
University Of Madras,
Chennai.

Ph: 9940357430
Email: saiprasannasp@yahoo.com   

---------------------------------
Love cheap thrills? Enjoy PC-to-Phone  calls to 30+ countries for just 2�/min with Yahoo! Messenger with Voice.

			
---------------------------------
Yahoo! Messenger with Voice. PC-to-Phone calls for ridiculously low rates.
--0-2131947936-1144827494=:39064
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<br><blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Date: Wed, 12 Apr 2006 00:04:59 -0700 (PDT)<br>From: Sai prasanna &lt;saiprasannasp@yahoo.com&gt;<br>Subject: BFD 2.16.1 assertion fail<br>To: linux project group &lt;linux_projects_2006@yahoogroups.com&gt;<br>CC: saiprasannasp@yahoo.com<br><br> Hi All,<br><br>I Have been trying to build across compiler for power-ppc-linux-gnu I have succesfully installed binutils-2.16.1, first phase gcc-4.0.3, glibc-2.3.6 and then when i finally tried to install the final gcc ima getting eror such as<br><br>/home/foo/build-install/powerpc-ppc-linux-gnu/bin/ld: BFD 2.16.1 assertion fail../../binutils-2.16.1/bfd/elf32-ppc.c:5397<br>collect2: ld returned 1 exit status<br>make[3]: *** [libmudflap.la] Error 1<br>make[3]: Leaving directory `/home/foo/build-gcc/powerpc-ppc-linux-gnu/libmudflap'<br>make[2]: *** [all-recursive] Error 1<br>make[2]: Leaving directory
 `/home/foo/build-gcc/powerpc-ppc-linux-gnu/libmudflap'<br>make[1]: *** [all] Error 2<br>make[1]: Leaving directory `/home/foo/build-gcc/powerpc-ppc-linux-gnu/libmudflap'<br>make: *** [all-target-libmudflap] Error 2<br><br>I have used the following gcc configuration opitons<br><br>[root@localhost build-gcc]# ../gcc-4.0.3/configure --host=i686-pc-linux-gnu  --target=powerpc-ppc-linux-gnu --prefix=/home/foo/build-install --enable-languages=c,c++ <br><br>Some one please help me with this.<br><br>Regards,<br>Sai &nbsp;&nbsp;&nbsp;&nbsp; <br><br><br>Sai Prasanna.S,<br>Department Of ComputerScience,<br>University Of Madras,<br>Chennai.<br><br>Ph: 9940357430<br>Email: saiprasannasp@yahoo.com<div>   </div><hr size="1">Love cheap thrills? Enjoy PC-to-Phone <a href="http://us.rd.yahoo.com/mail_us/taglines/postman9/*http://us.rd.yahoo.com/evt=39666/*http://beta.messenger.yahoo.com/"> calls to 30+ countries</a> for just 2�/min with Yahoo! Messenger with Voice.</blockquote><br><p>
	
		<hr size=1><a href="http://us.rd.yahoo.com/mail_us/taglines/postman3/*http://us.rd.yahoo.com/evt=39666/*http://beta.messenger.yahoo.com">Yahoo! Messenger with Voice.</a> PC-to-Phone calls for ridiculously low rates.
--0-2131947936-1144827494=:39064--
