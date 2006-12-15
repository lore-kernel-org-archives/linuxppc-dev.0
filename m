Return-Path: <svallet@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id 1156867BB2
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 22:25:08 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id n15so976458nfc
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 03:25:06 -0800 (PST)
Message-ID: <6473fb3e0612150325w3c6f01b0rdd4953dc9cb6430e@mail.gmail.com>
Date: Fri, 15 Dec 2006 12:25:05 +0100
From: "Simon Vallet" <svallet@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: atomic_clear_mask() on PPC ?
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_177214_32822478.1166181905714"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_177214_32822478.1166181905714
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm currently trying to "port" a binary-only driver to Linux/PPC : the card
manufacturer
provides MacOS X and Linux/i386 drivers, providing *some* sources with the
Linux driver.

The plan is to use the provided sources, and to get the remaining symbols &
code from the MacOSX
object -- Unfortunately, one of those components makes a call to
atomic_clear_mask(), which doesn't
seem available on PPC yet.

So the question is : is there a workaround for this, and if not, how would
you implement this call
(I have absolutely no knowledge of PPC assembly). Quickly grepping through
kernel headers reveals it
is present for i386, arm and x86_64, but not sparc or ppc. Is there a reason
for this ?

Simon

------=_Part_177214_32822478.1166181905714
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I'm currently trying to &quot;port&quot; a binary-only driver to Linux/PPC : the card manufacturer<br>provides MacOS X and Linux/i386 drivers, providing *some* sources with the Linux driver.<br><br>The plan is to use the provided sources, and to get the remaining symbols &amp; code from the MacOSX
<br>object -- Unfortunately, one of those components makes a call to atomic_clear_mask(), which doesn't <br>seem available on PPC yet.<br><br>So the question is : is there a workaround for this, and if not, how would you implement this call 
<br>(I have absolutely no knowledge of PPC assembly). Quickly grepping through kernel headers reveals it<br>is present for i386, arm and x86_64, but not sparc or ppc. Is there a reason for this ?<br><br>Simon<br><br>

------=_Part_177214_32822478.1166181905714--
