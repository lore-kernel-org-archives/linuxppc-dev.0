Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 14276DDE46
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Nov 2007 01:58:06 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA1Ew3l9008127
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Nov 2007 10:58:03 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA1EvtFG024448
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Nov 2007 08:57:59 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA1EvtKb020068
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Nov 2007 08:57:55 -0600
Date: Thu, 1 Nov 2007 09:57:54 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: Please pull from 'for-2.6.24' branch of 4xx tree
Message-ID: <20071101095754.7c2f873c@weaponx.rchland.ibm.com>
In-Reply-To: <4729E897.1070400@harris.com>
References: <20071101081057.46a9bfdd@weaponx.rchland.ibm.com>
	<4729E897.1070400@harris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 01 Nov 2007 10:54:15 -0400
"Steven A. Falco" <sfalco@harris.com> wrote:

> Is this something anyone can do?  I tried:
> 
> git pull 
> master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git 
> for-2.6.24
> 
> but it asks me for a password.  I'd like to be able to follow your 
> development branch, so I can contribute patches where appropriate.

Ah.  No, you'd have to have an account on master.kernel.org for that
specific pull request to work.  Anonymous pulls should work with:

git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git

as the URL instead.

josh
