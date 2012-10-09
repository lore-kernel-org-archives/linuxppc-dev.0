Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id CF0282C00A7
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2012 02:11:37 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 26095-10 for <linuxppc-dev@ozlabs.org>;
 Tue,  9 Oct 2012 16:04:55 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH 06/20] powerpc/xmon: Remove renaming #defines of scanhex()
 and skipbl()
Date: Tue, 9 Oct 2012 15:59:24 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7028@saturn3.aculab.com>
In-Reply-To: <1349792447-15714-6-git-send-email-michael@ellerman.id.au>
References: <1349792447-15714-1-git-send-email-michael@ellerman.id.au>
 <1349792447-15714-6-git-send-email-michael@ellerman.id.au>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Michael Ellerman" <michael@ellerman.id.au>,
	<linuxppc-dev@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> We have two #defines that rename scanhex() and skipbl() to
> xmon_scanhex() and xmon_skipbl() - but no one ever uses those
> names.

It looks like they are there for namespace protection.

	David
