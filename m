Return-Path: <annamaya@yahoo.com>
Received: from web53809.mail.yahoo.com (web53809.mail.yahoo.com
	[206.190.36.204]) by ozlabs.org (Postfix) with SMTP id 236332BF07
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Jan 2005 09:51:24 +1100 (EST)
Message-ID: <20050104225123.214.qmail@web53809.mail.yahoo.com>
Date: Tue, 4 Jan 2005 14:51:22 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Cross-compiling for MPC82xx on an Apple G5
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I was wondering if code cross-compiled on a G5 host
machine for the MPC82xx would actually run on the G5?
I see that the G5 is a 64-bit processor. Is that going
to be a problem?

The only reason I am asking about this is because some
packages create intermediate executables that are
executed during the latter stages of the build
process. I would like to cross-compile some readily
available packages that are not designed to be
cross-compiled easily. I remember doing something
similar to this on a Apple G4 a long time ago. 


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 
