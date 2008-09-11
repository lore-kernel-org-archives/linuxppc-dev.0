Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A9468DE007
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 07:07:11 +1000 (EST)
Subject: Git branch conventions
From: Nate Case <ncase@xes-inc.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 11 Sep 2008 15:22:57 -0500
Message-Id: <1221164577.10636.390.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Can you (or anyone really) describe what the usage conventions are for
the master, powerpc-next, and merge branches in your tree?

The 'master' and 'powerpc-next' branches appear to be identical right
now.  I can see that you usually submit pull requests to Linus via your
'merge' branch.  I also notice that there are changes in 'merge' that
aren't in 'master' or 'powerpc-next'.  Likewise, I see changes in
'powerpc-next'/'master' that aren't in 'merge'.  Is
'powerpc-next'/'master' purely 2.6.28 material currently while 'merge'
is for whatever the next target release is (currently 2.6.27)?

I couldn't find this explained officially anywhere, so I thought I'd
ask.  Maybe it'd shed some light for other people too.

-- 
Nate Case <ncase@xes-inc.com>
