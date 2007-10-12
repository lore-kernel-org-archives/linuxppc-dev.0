Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 23D04DDE0D
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2007 04:39:41 +1000 (EST)
In-Reply-To: <fa686aa40710121130p7ec957bar471c2e8245bd162b@mail.gmail.com>
References: <fa686aa40710121130p7ec957bar471c2e8245bd162b@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <903EBFBB-D6B6-42EA-A0E3-63CAA55F6E23@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: mpc52xx bestcomm patches.
Date: Fri, 12 Oct 2007 13:40:04 -0500
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 12, 2007, at 1:30 PM, Grant Likely wrote:

> Paulus, how do you feel about merging these changes?
>
> This is Sylvain's series of bestcomm patches.
>
> http://patchwork.ozlabs.org/linuxppc/patch?id=13488
> http://patchwork.ozlabs.org/linuxppc/patch?id=13489
> http://patchwork.ozlabs.org/linuxppc/patch?id=13490
> http://patchwork.ozlabs.org/linuxppc/patch?id=13491
> http://patchwork.ozlabs.org/linuxppc/patch?id=13492
> http://patchwork.ozlabs.org/linuxppc/patch?id=13493
> http://patchwork.ozlabs.org/linuxppc/patch?id=13494
>
> There are still a few minor issues to be resolved, but Sylvain is
> suffering from a severe lack of time and this series has been stalled
> for a long time because of it.  Domen and others have been working on
> drivers which use bestcomm, but they can neither get their drivers
> included nor address the issues in this series because of it.
>
> Personally, I think it will be better to just merge it now and allow
> others to address the remaining comments.  It's not like this is a
> change to an old device that could be risky.

I'm against this getting merged w/o addressing some of the long  
standing comments I've made:

http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036224.html
http://ozlabs.org/pipermail/linuxppc-dev/2007-September/042632.html
http://ozlabs.org/pipermail/linuxppc-dev/2007-September/042633.html

Additionally I think ALL new "libraries" like this should come with  
kerneldoc.

- k
