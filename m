Return-Path: <subbu.linux@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.229])
	by ozlabs.org (Postfix) with ESMTP id ECD7ADDF3C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Aug 2007 21:14:29 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so676495wxd
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Aug 2007 04:14:28 -0700 (PDT)
Message-ID: <f807f08a0708110414p2b9fc7c0s94dd9d10214296d5@mail.gmail.com>
Date: Sat, 11 Aug 2007 16:44:28 +0530
From: "Subbu Linux" <subbu.linux@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Is it possible to move Kernel Virtual Space to 0xE0000000
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_30418_1763786.1186830868299"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_30418_1763786.1186830868299
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello PPCTeam,
I would like to know whether I can move kernel virtual space to 0xE0000000
from 0xC0000000, if so can someone suggest me what are the pros and cons, I
know moving kernel is not good idea since Non Linux Standard, but then I
need to expand user space as one of my applications uses huge mmap space.
I tried so far
Giving Kernel virtual space to 0xD0000000 and it boots without any problems,
however when I increase it more to 0xE0000000 it throws Program Exception. I
will be glad if someone helps me out with refernces for Linux Porting on
MPCs.

Regards
Subbu

------=_Part_30418_1763786.1186830868299
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hello PPCTeam,</div>
<div>I would like to know whether I can move kernel virtual space to 0xE0000000 from 0xC0000000, if so can someone suggest me what are the pros and cons, I know moving kernel is not good idea since Non Linux Standard, but then I need to expand&nbsp;user space as&nbsp;one of my applications uses huge mmap space.
</div>
<div>I tried so far </div>
<div>Giving Kernel virtual space to 0xD0000000 and it boots without any problems, however when I increase it more to 0xE0000000 it throws Program Exception. I will be glad if someone helps me out with refernces for Linux Porting on MPCs.
</div>
<div>&nbsp;</div>
<div>Regards</div>
<div>Subbu</div>

------=_Part_30418_1763786.1186830868299--
