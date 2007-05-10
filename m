Return-Path: <mgreer@mvista.com>
Date: Thu, 10 May 2007 16:00:42 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: arch/powerpc/sysdev: dumping ground or only for shared drivers?
Message-ID: <20070510230042.GB4562@mag.az.mvista.com>
References: <20070510200237.GA19756@mag.az.mvista.com>
	<20070510215730.GA25075@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070510215730.GA25075@lixom.net>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 10, 2007 at 04:57:30PM -0500, Olof Johansson wrote:
> In my opinion, they really should go under the platform directory instead,
> and not clutter the shared directory.
> 
> Same with tsi*, it should probably be moved, as well as the 8xx*
> drivers. fsl_* seems to be shared, so does cpm2*.
> 
> embedded6xx has a handful of different chipsets, so it could make sense
> to create a subdir under platforms/embedded6xx for chipset support,
> but there's no need to keep them in sysdev.

Makes sense to me.

Mark
