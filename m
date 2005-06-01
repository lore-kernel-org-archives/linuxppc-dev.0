Return-Path: <mlei30@yahoo.com>
Received: from web61016.mail.yahoo.com (web61016.mail.yahoo.com
	[209.73.179.10]) by ozlabs.org (Postfix) with SMTP id 8E463679EF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Jun 2005 07:32:09 +1000 (EST)
Message-ID: <20050601213207.68971.qmail@web61016.mail.yahoo.com>
Date: Wed, 1 Jun 2005 14:32:07 -0700 (PDT)
From: ming lei <mlei30@yahoo.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <20050524133819.B23084@cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: Does linuxppc_2_4_devel still accept patch?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I found there is a serious problem in head_440.S
regarding the handling of mmucr in DataTLBmiss and
InstructionTLBmiss exceptions in 2.4 linux ppc branch.
Where should I submit the changes?

Which branch right now is active for ppc44x
development? Have we moved to linux kernel 2.6
official development already?

Ming

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
