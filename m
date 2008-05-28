Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83512.mail.sp1.yahoo.com (web83512.mail.sp1.yahoo.com
	[216.252.120.168]) by ozlabs.org (Postfix) with SMTP id 9461DDDF65
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 04:39:20 +1000 (EST)
Date: Wed, 28 May 2008 11:39:18 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: JFFS2 FS not writeable
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <483C771A.7050003@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <80364.25515.qm@web83512.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--- Scott Wood <scottwood@freescale.com> wrote:
> You may want to try increasing the OR[SCY] field or
> other timing 
> parameters associated with the NAND flash.

So are you saying that when this happened in the past
it was a timing issue?  This change would need to
happen in u-boot correct?

Ron
