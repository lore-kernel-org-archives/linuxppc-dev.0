Return-Path: <wmaxfield@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 9C73567BCD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 06:37:57 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so248939ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Aug 2006 13:37:55 -0700 (PDT)
Message-ID: <45a1b53e0608231337h5cde89d9u604200bf503f8ff6@mail.gmail.com>
Date: Wed, 23 Aug 2006 15:37:54 -0500
From: "Wade Maxfield" <wmaxfield@gmail.com>
To: ppc <linuxppc-embedded@ozlabs.org>
Subject: crashes on NFS
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_107721_4799728.1156365474892"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_107721_4799728.1156365474892
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

  I accidentally posted some kernel crashes when running updatedb on an
ML403 using MontaVista tools.  I was meaning to send them to MV.

  I had swap enabled over NFS (128meg), and the NFS directory being exported
was about 2 gigabytes in sizes.

  According to MontaVista, the problem was the kernel was running out of
memory.  (There are 64 megs of ram on that board.)

  I guess updatedb is very greedy.

thanks,
wade

------=_Part_107721_4799728.1156365474892
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>&nbsp; I accidentally posted some kernel crashes when running updatedb on an ML403 using MontaVista tools.&nbsp; I was meaning to send them to MV.<br><br>&nbsp; I had swap enabled over NFS (128meg), and the NFS directory being exported was about 2 gigabytes in sizes.
<br><br>&nbsp; According to MontaVista, the problem was the kernel was running out of memory.&nbsp; (There are 64 megs of ram on that board.)<br><br>&nbsp; I guess updatedb is very greedy.<br><br>thanks,<br>wade<br><br><br><br>

------=_Part_107721_4799728.1156365474892--
