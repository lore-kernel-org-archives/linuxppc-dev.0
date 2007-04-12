Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <200704122043.38679.arnd@arndb.de>
References: <20070410111508.GA2969@localhost.localdomain>
	<ffb78cbadfea8d104c8e5d495e9651ca@kernel.crashing.org>
	<20070412042337.GA21832@aepfle.de>
	<200704122043.38679.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cd65a3043da12cd180e2b3ea91bbc123@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [patch 3/3] cell: prevent alignment interrupt on
	local store
Date: Thu, 12 Apr 2007 21:52:22 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Building with -mcpu=cell won't work on 970 or g4, because that enables
> a few extra instructions that were not present in the older cpus.
>
> If you know you want to build with altivec (i.e. not run on power4 or
> older), then '-m32 -mcpu=7450 -mtune=cell' or '-m64 -mcpu=970 
> -mtune=cell'
> would be a reasonable thing to try.

-mcpu=powerpc64 -mtune=cell


Segher
