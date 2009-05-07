Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 8FE97DDDB6
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 15:32:40 +1000 (EST)
To: Chris Plasun <chrispl78@yahoo.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Trouble using with Kegel cross tool chain
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <407093.53240.qm@web58102.mail.re3.yahoo.com>
References: <407093.53240.qm@web58102.mail.re3.yahoo.com>
Date: Thu, 07 May 2009 07:32:36 +0200
Message-Id: <20090507053236.0E2AF83420E8@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Chris,

In message <407093.53240.qm@web58102.mail.re3.yahoo.com> you wrote:
> 
> I'm getting a bit desperate trying to build a  gcc / glibc cross-toolchainfor 
> use on a Freescale MPC8313 but am having problems.

Try using ELDK (see http://www.denx.de/wiki/view/DULG/ELDK resp.
ftp://ftp.denx.de/pub/eldk/4.2/); it's based on crosstool but has
these issues already solved for you.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There are bugs and then there are bugs.  And then there are bugs.
                                                    - Karl Lehenbauer
