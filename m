Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 71760DE130
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 13:31:48 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18917.21789.425744.170039@drongo.ozlabs.ibm.com>
Date: Wed, 15 Apr 2009 13:31:41 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'merge' branch (for 2.6.30)
In-Reply-To: <Pine.LNX.4.64.0904141142240.1013@localhost.localdomain>
References: <Pine.LNX.4.64.0904141142240.1013@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Please pull from 'merge' branch of
> 
> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git merge

Thanks, pulled.  I'll collect up a few more patches for .30 and send
Linus a pull request shortly.

By the way, I'm not planning to run test or next branches while Ben is
away.  He'll be back in plenty of time to collect the patches for .31
before the next merge window.

Paul.
