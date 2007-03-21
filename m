Return-Path: <b07421@freescale.com>
Date: Wed, 21 Mar 2007 16:57:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/4] powerpc: Add device tree utility functions to zImage
Message-ID: <20070321215741.GA5540@ld0162-tx32.am.freescale.net>
References: <20070321063031.GB30422@localhost.localdomain>
	<20070321063150.04BA4DDE9F@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070321063150.04BA4DDE9F@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2007 at 05:31:49PM +1100, David Gibson wrote:
> +int dt_path_getprop(const char *path, const char *name, void *buf, int bufsize)
> +{
> +	void *devp = finddevice;
> +
> +	if (devp)
> +		return getprop(devp, name, buf, bufsize);
> +	return -1;
> +}

Should be "void *devp = finddevice(path);".

-Scott
