Return-Path: <tur@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79199DE58F
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 09:08:33 +1100 (EST)
Message-ID: <47ED6BE5.9060807@semihalf.com>
Date: Fri, 28 Mar 2008 23:06:29 +0100
From: Bartlomiej Sieka <tur@semihalf.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull powerpc.git merge branch
References: <18412.58902.189124.391104@cargo.ozlabs.ibm.com>
In-Reply-To: <18412.58902.189124.391104@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Linus,
> 
> I have added another commit to the powerpc.git merge branch, so when
> you do:
> 
> git pull \
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge
> 
> you'll get a fix for a bug where the hardware data breakpoint would
> sometimes fail to trigger on powerpc, if multiple threads put a
> breakpoint on the same address.  The bug has been around for a while
> and Michael Ellerman just found the cause and posted a fix.

Hello Paul,

What about http://patchwork.ozlabs.org/linuxppc/patch?id=17525 ? I don't
see it in the merge branch of your repository, and it would be nice to
get it upstream as it fixes boot problems on some MPC5200-based boards.

Regards,
Bartlomiej
