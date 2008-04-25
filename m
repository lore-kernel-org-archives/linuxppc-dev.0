Return-Path: <killyouatonce@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id 7A14CDDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Apr 2008 13:18:57 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 25so2853478wfa.15
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 20:18:56 -0700 (PDT)
Message-ID: <931ae8260804242018n45ced2e3v31c91a49c41455d4@mail.gmail.com>
Date: Fri, 25 Apr 2008 11:18:56 +0800
From: "yanlong wang" <killyouatonce@gmail.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: Re: ppc-linux still not booting on my virtexII board
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1015_6436489.1209093536186"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_1015_6436489.1209093536186
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

   Hi , guys , i meet the same problem as yours . when it  into the
early_init(), the system was hang up .  I see your solution , but i don't
known it clearly . Can you tell me detailly ??? Why it happened and the
solution .
   Waiting for your reply , thank you :)


Hi,

>* (...)arch/ppc/boot/simple/embed_config.c
*
Oops, I skipped that code because my bootloader executes the uncompressed
kernel image (loaded at 0x00000000) without doing that stuff in the first
place. All right ;)

Thanks again,
Patrick

------=_Part_1015_6436489.1209093536186
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp; Hi , guys , i meet the same problem as yours . when it&nbsp; into the early_init(), the system was hang up .&nbsp; I see your solution , but i don&#39;t known it clearly . Can you tell me detailly ??? Why it happened and the solution .<br>
&nbsp;&nbsp; Waiting for your reply , thank you :)<br><br><pre><br>Hi,<br><br>&gt;<i> (...)arch/ppc/boot/simple/embed_config.c<br></i><br>Oops, I skipped that code because my bootloader executes the uncompressed<br>kernel image (loaded at 0x00000000) without doing that stuff in the first<br>
place. All right ;)<br><br>Thanks again,<br>Patrick<br><br></pre><br>

------=_Part_1015_6436489.1209093536186--
