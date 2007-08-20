Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62A38DDE02
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 22:33:35 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7KCXW07008255
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 08:33:32 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7KCXVdA269978
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 06:33:31 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7KCXV0x017366
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 06:33:31 -0600
Date: Mon, 20 Aug 2007 07:33:30 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull from 'for-2.6.24' branch
Message-ID: <20070820073330.6e325480@weaponx.rchland.ibm.com>
In-Reply-To: <18121.7269.300478.589492@cargo.ozlabs.ibm.com>
References: <20070817084623.3e9835d0@weaponx.rchland.ibm.com>
	<18121.7269.300478.589492@cargo.ozlabs.ibm.com>
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

On Mon, 20 Aug 2007 14:45:25 +1000
Paul Mackerras <paulus@samba.org> wrote:

> Josh Boyer writes:
> 
> > Josh Boyer (10):
> >       Rename 4xx paths to 40x
> >       4xx Kconfig cleanup
> >       Rename 44x bootwrapper
> >       4xx bootwrapper reworks
> >       40x MMU
> >       40x decrementer fixes
> >       Fix 40x build
> >       Bamboo DTS
> >       Bamboo board support
> >       Bamboo zImage wrapper
> 
> Could you re-do these with [POWERPC] at the start of the summary line?

Yes, done.  Git tree is updated:

Josh Boyer (10):
      [POWERPC] Rename 4xx paths to 40x
      [POWERPC] 4xx Kconfig cleanup
      [POWERPC] Rename 44x bootwrapper
      [POWERPC] 4xx bootwrapper reworks
      [POWERPC] 40x MMU
      [POWERPC] 40x decrementer fixes
      [POWERPC] Fix 40x build
      [POWERPC] Bamboo DTS
      [POWERPC] Bamboo board support
      [POWERPC] Bamboo zImage wrapper

josh
