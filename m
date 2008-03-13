Return-Path: <agx@sigxcpu.org>
Received: from honk.sigxcpu.org (static-87-79-238-240.netcologne.de
	[87.79.238.240])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "honk.sigxcpu.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0EA61DDEF0
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 19:31:05 +1100 (EST)
Date: Thu, 13 Mar 2008 09:30:23 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH 1/4] Ensure that pmu_sys_suspended exists in
	appropriate configs.
Message-ID: <20080313083023.GB15949@bogon.ms20.nix>
References: <66e63844f95778cdc331d245889ff0ebfe17bbb4.1205279151.git.tony@bakeyournoodle.com>
	<20080312083857.GB19504@bogon.ms20.nix>
	<20080312212005.GU6887@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080312212005.GU6887@bakeyournoodle.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Tony,
On Thu, Mar 13, 2008 at 08:20:05AM +1100, Tony Breeds wrote:
[..snip..] 
> where pmu_sys_suspended is referenced and I'm having difficulty
> understanding how CONFIG_HIBERNATION is affecting that.
I mangled the filenames and didn't notice that you fixed the header file
instead of via-pmu.c. Yes, this should work. Thanks for fixing this 
and the apm-emu stuff as well.
Cheers,
 -- Guido
