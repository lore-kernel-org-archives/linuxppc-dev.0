Return-Path: <roland@redhat.com>
Received: from QMTA09.emeryville.ca.mail.comcast.net
	(qmta09.emeryville.ca.mail.comcast.net [76.96.30.96])
	by ozlabs.org (Postfix) with ESMTP id A9245DDFB9
	for <linuxppc-dev@ozlabs.org>; Sat, 10 May 2008 05:45:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: patch to install unstripped vDSO on disk breaks powerpc kernel
	build
In-Reply-To: Chris Friesen's message of  Friday,
	9 May 2008 11:16:39 -0600 <482486F7.3090805@nortel.com>
References: <482486F7.3090805@nortel.com>
Message-Id: <20080509194427.3BDB126FA85@magilla.localdomain>
Date: Fri,  9 May 2008 12:44:27 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I haven't seen that error before.  Can you show the output of {eu-,}readelf -lS
on vdso64.so.dbg, and also on the vdso64.so successfully built when you
revert the patch?


Thanks,
Roland
