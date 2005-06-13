Return-Path: <pniyogi@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.132])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9AE65679EA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Jun 2005 23:45:59 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j5DDjs2h490752
	for <linuxppc-embedded@ozlabs.org>; Mon, 13 Jun 2005 09:45:54 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j5DDjstH221960
	for <linuxppc-embedded@ozlabs.org>; Mon, 13 Jun 2005 07:45:54 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	j5DDjs6I032284
	for <linuxppc-embedded@ozlabs.org>; Mon, 13 Jun 2005 07:45:54 -0600
Received: from d03nm132.boulder.ibm.com (d03nm132.boulder.ibm.com
	[9.17.195.172])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	j5DDjstg032275
	for <linuxppc-embedded@ozlabs.org>; Mon, 13 Jun 2005 07:45:54 -0600
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Message-ID: <OF6BE916AF.4D6A65C4-ON8625701F.004ACEBA-8625701F.004B9D77@us.ibm.com>
From: Prosun Niyogi <pniyogi@us.ibm.com>
Date: Mon, 13 Jun 2005 08:45:53 -0500
Content-Type: multipart/alternative;
	boundary="=_alternative 004B9D768625701F_="
Subject: KGDB on BookE
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 004B9D768625701F_=
Content-Type: text/plain; charset="US-ASCII"

I've grabbed latest kernel.org kernel (2.6.11.11) to attempt to get a 
working kgdb on my ebony setup. Checking the mailing list archives, it 
seems as if all the 4xx specific kgdb patches have been merged with 
kernel.org. Is this the case? If so, I have a problem single stepping 
using kgdb. The debugger_sstep(regs) function is never called from 
traps.c. So, as of right now.. I can only set/hit an arbitrary breakpoint 
(for my testing, I've been setting a breakpoint at sys_sync). After 
setting the breakpoint and continuing from the initial kgdb entry point, 
gdb successfully catches the breakpoint at sys_sync, but when I attempt to 
step, the kernel continues normal operation, and subsequent attempts at 
breaking into gdb control by issuing a "sync" command on the ebony 
terminal in minicom do not hit the breakpoint. Any pointers/suggestions as 
to where I can obtain a working kgdb-enabled kernel for the ebony board? 
Any assistance would be helpful. 

Thanks.

Prosun Niyogi
Software Engineer 
Linux Technology Center
Phone:(512)838-8364 (TL 678-8364)
Fax:(512)838-4663
pniyogi@us.ibm.com
--=_alternative 004B9D768625701F_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">I've grabbed latest kernel.org kernel
(2.6.11.11) to attempt to get a working kgdb on my ebony setup. Checking
the mailing list archives, it seems as if all the 4xx specific kgdb patches
have been merged with kernel.org. Is this the case? If so, I have a problem
single stepping using kgdb. The debugger_sstep(regs) function is never
called from traps.c. So, as of right now.. I can only set/hit an arbitrary
breakpoint (for my testing, I've been setting a breakpoint at sys_sync).
After setting the breakpoint and continuing from the initial kgdb entry
point, gdb successfully catches the breakpoint at sys_sync, but when I
attempt to step, the kernel continues normal operation, and subsequent
attempts at breaking into gdb control by issuing a &quot;sync&quot; command
on the ebony terminal in minicom do not hit the breakpoint. Any pointers/suggestions
as to where I can obtain a working kgdb-enabled kernel for the ebony board?
Any assistance would be helpful. </font>
<br>
<br><font size=2 face="sans-serif">Thanks.</font>
<br>
<br><font size=2 face="sans-serif">Prosun Niyogi<br>
Software Engineer <br>
Linux Technology Center<br>
Phone:(512)838-8364 (TL 678-8364)<br>
Fax:(512)838-4663<br>
pniyogi@us.ibm.com</font>
--=_alternative 004B9D768625701F_=--
