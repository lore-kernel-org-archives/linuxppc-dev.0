Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DBD03DDFBB
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 22:56:49 +1000 (EST)
Message-Id: <653F1FB5-95F5-4A33-B716-7906BEA54769@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18486.37948.843161.645634@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: New commits in powerpc.git powerpc-next branch
Date: Fri, 23 May 2008 07:56:44 -0500
References: <18486.37948.843161.645634@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 23, 2008, at 4:54 AM, Paul Mackerras wrote:

> I have pushed the following commits to the powerpc-next and master
> branches of the powerpc.git repository.  I have also pulled in Linus'
> tree plus the 5 commits that I have put on the merge branch and asked
> Linus to pull.
>
> Paul.
>
> Anton Vorontsov (1):
>      [POWERPC] of/gpio: Use dynamic base allocation
>
> Kumar Gala (1):
>      [POWERPC] mpic: Deal with bogus NIRQ in Feature Reporting  
> Register
>
> Michael Ellerman (2):
>      [POWERPC] Add debugging trigger to Axon MSI code
>      [POWERPC] Remove unnecessary cast in arch_deref_entry_point()
>
> Roland McGrath (1):
>      [POWERPC] Tweak VDSO linker script to avoid upsetting old  
> binutils

Paul, you some how merged Roland's patch and my book-e comment patch  
together.  Its not a big deal, but FYI.

- k
