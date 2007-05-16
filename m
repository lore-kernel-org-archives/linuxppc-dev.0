Return-Path: <johnrose@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B15EDDEDB
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 07:23:21 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4GLNIDO001675
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 17:23:18 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4GLNIm3530532
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 17:23:18 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4GLNI3e001313
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 17:23:18 -0400
Subject: Re: [viro@ftp.linux.org.uk: [PATCH] rpadlpar breakage - fallout of
	struct subsystem removal]
From: John Rose <johnrose@austin.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>, Greg KH <greg@kroah.com>,
	michael@ellerman.id.au, Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20070515194729.GE4095@ftp.linux.org.uk>
References: <20070515194729.GE4095@ftp.linux.org.uk>
Content-Type: text/plain
Date: Wed, 16 May 2007 16:22:37 -0500
Message-Id: <1179350557.14199.10.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Verified boot, hotplug, and dynamic add/remove of buses.  Perfect,
thanks Al!

Acked-by: John Rose <johnrose@austin.ibm.com>
