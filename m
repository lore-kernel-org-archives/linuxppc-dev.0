Return-Path: <cchaoyu@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id AC12567B54
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jul 2006 09:26:14 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id h2so44481ugf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Jul 2006 16:26:12 -0700 (PDT)
Message-ID: <56c993430607111618q2cd0cfach4abb4d15ea25d05@mail.gmail.com>
Date: Wed, 12 Jul 2006 07:18:53 +0800
From: "chao yu" <cchaoyu@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: "Bad trap at PC: 3000xxxx, SR: xxxx, vector=xxx Not tainted"
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2156_1703857.1152659933241"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_2156_1703857.1152659933241
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I port the linux 2.4 kernel to our mpc8541 board, but when it executes the
run_init_process("/sbin/init") in the init function, it will disaplay "Bad
trap at PC: 3000xxxx, SR: xxxx, vector=xxx    Not tainted" continually. The
ramdisk is from ELDK 4.0 package for 85xx which is pre-built. Who can tell
me what was happened?

------=_Part_2156_1703857.1152659933241
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I port the linux 2.4 kernel to our mpc8541 board, but when it executes the run_init_process(&quot;/sbin/init&quot;) in the init function, it will disaplay &quot;Bad trap at PC: 3000xxxx, SR: xxxx, vector=xxx&nbsp;&nbsp;&nbsp; Not tainted&quot; continually. The ramdisk is from ELDK 
4.0 package for 85xx which is pre-built. Who can tell me what was happened?

------=_Part_2156_1703857.1152659933241--
