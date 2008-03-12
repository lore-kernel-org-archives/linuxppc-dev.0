Return-Path: <agx@sigxcpu.org>
Received: from honk.sigxcpu.org (static-87-79-238-240.netcologne.de
	[87.79.238.240])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "honk.sigxcpu.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 06D9EDDDEE
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 19:39:09 +1100 (EST)
Date: Wed, 12 Mar 2008 09:38:57 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH 1/4] Ensure that pmu_sys_suspended exists in
	appropriate configs.
Message-ID: <20080312083857.GB19504@bogon.ms20.nix>
References: <66e63844f95778cdc331d245889ff0ebfe17bbb4.1205279151.git.tony@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <66e63844f95778cdc331d245889ff0ebfe17bbb4.1205279151.git.tony@bakeyournoodle.com>
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
On Wed, Mar 12, 2008 at 10:48:48AM +1100, Tony Breeds wrote:
> pmu_sys_suspended is declared extern when:
> 	defined(CONFIG_PM_SLEEP) && defined(CONFIG_PPC32)
> but only defined when:
> 	defined(CONFIG_SUSPEND) && defined(CONFIG_PPC32)
> which is wrong.  Lets fix that.
As I wrote, this isn't defined in my config:

# CONFIG_SUSPEND is not set
CONFIG_HIBERNATION=y

Cheers,
 -- Guido
