Return-Path: <annamaya@yahoo.com>
Received: from web53808.mail.yahoo.com (web53808.mail.yahoo.com
	[206.190.36.203]) by ozlabs.org (Postfix) with SMTP id D65032BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Nov 2004 03:37:30 +1100 (EST)
Message-ID: <20041109163726.30776.qmail@web53808.mail.yahoo.com>
Date: Tue, 9 Nov 2004 08:37:25 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: MPC8xx binaries running on a MPC82xx board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I was under the assumption that the MPC8xx core was
different from the MPC82xx core (the 603e?). But I was
surprised to find that the MPC8xx binaries were
running fine on a MPC82xx binaries, even if they were
dynamically linked and were linking to the MPC82xx
libraries. What's going on here? Can I just use the
8xx toolkit to work with the 82xx? There must be SOME
differences between these two architectures. Can
someone here explain this to me?


		
__________________________________ 
Do you Yahoo!? 
Check out the new Yahoo! Front Page. 
www.yahoo.com 
 
