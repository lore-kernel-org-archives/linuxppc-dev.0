Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 51F02B7D23
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Feb 2010 01:10:16 +1100 (EST)
Date: Mon, 8 Feb 2010 15:09:56 +0100
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Kexec support for FSL-BookE, take two
Message-ID: <20100208140956.GA11962@Chamillionaire.breakpoint.cc>
References: <1263573697-17839-1-git-send-email-linuxppc-dev@ml.breakpoint.cc>
	<80DDCCCD-D62C-4A66-AA8B-E0937266AF55@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <80DDCCCD-D62C-4A66-AA8B-E0937266AF55@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Kumar Gala | 2010-01-15 11:53:13 [-0600]:

>On Jan 15, 2010, at 10:41 AM, Sebastian Andrzej Siewior wrote:
>
>> This is take two :)
>What do you think we need for SMP support? I'm happy to test out on SMP HW (8572)

I've updated a comment in the last patch which was wrong. I've pushed
the updated patch to my git tree at [0]. I can post the whole patch if
you want :)
Do you have any idea when you will be able to take a look at this
series?

[0] http://git.breakpoint.cc/cgi-bin/gitweb.cgi?p=bigeasy/linux.git;a=shortlog;h=refs/heads/kexec_booke

>- k

Sebastian
