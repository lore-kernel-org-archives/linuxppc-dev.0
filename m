Return-Path: <rick811us@yahoo.com>
Received: from web55605.mail.re4.yahoo.com (web55605.mail.re4.yahoo.com
	[206.190.58.229]) by ozlabs.org (Postfix) with SMTP id F0F3CDDE9F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Sep 2008 07:49:11 +1000 (EST)
Date: Wed, 24 Sep 2008 14:42:29 -0700 (PDT)
From: xyz <rick811us@yahoo.com>
Subject: nanosleep() and hrtimer on PPC64
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <629908.35392.qm@web55605.mail.re4.yahoo.com>
Reply-To: rick811us@yahoo.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi, all,

Does anyone know why nanosleep system call does not use kernel high resolution timer on 2.6.21 (PPC64)? This makes user space nanosleep() almost un-usable.
thanks

rick


      
