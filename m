Return-Path: <tur@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A9EDFDDEFF
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 01:34:05 +1100 (EST)
Message-ID: <47F39913.6090803@semihalf.com>
Date: Wed, 02 Apr 2008 16:32:51 +0200
From: Bartlomiej Sieka <tur@semihalf.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull powerpc.git merge branch
References: <18412.58902.189124.391104@cargo.ozlabs.ibm.com>	<47ED6BE5.9060807@semihalf.com>
	<18418.49494.457893.866627@cargo.ozlabs.ibm.com>
In-Reply-To: <18418.49494.457893.866627@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Bartlomiej Sieka writes:
> 
>> What about http://patchwork.ozlabs.org/linuxppc/patch?id=17525 ? I don't
>> see it in the merge branch of your repository, and it would be nice to
>> get it upstream as it fixes boot problems on some MPC5200-based boards.
> 
> It needs a proper stand-alone commit message and an acked-by from
> Grant.  The commit message should explain why you are making the
> changes you are making rather than just saying "the bulk of this patch
> is taken from http://...".

Paul,

Just re-sent the patch, please see 
http://patchwork.ozlabs.org/linuxppc/patch?id=17678; hopefully 
everything is OK now.

(Note that I've dropped torvalds@linux-foundation.org, 
akpm@linux-foundation.org and linux-kernel@vger.kernel.org from the CC:)

Regards,
Bartlomiej
