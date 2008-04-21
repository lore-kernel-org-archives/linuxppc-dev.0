Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5DCDCDE310
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 03:57:36 +1000 (EST)
Date: Mon, 21 Apr 2008 10:55:58 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Remi Machet <rmachet@slac.stanford.edu>
Message-ID: <20080421175558.GA12468@farnsworth.org>
References: <1208799408.5789.52.camel@pcds-ts102.slac.stanford.edu>
MIME-Version: 1.0
In-Reply-To: <1208799408.5789.52.camel@pcds-ts102.slac.stanford.edu>
Subject: Re: [PATCH 1/2 v2] sysdev,mv64x60: I2C defaults
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2008 at 10:36:48AM -0700, Remi Machet wrote:
> I2C parameters freq_m and freq_n are assigned default in the code
> but if those properties are not found in the open firmware description 
> the init returns an error => the code now uses the default
> values if the properties are not found.
> 
> Signed-off-by: Remi Machet (rmachet@slac.stanford.edu)

Acked-by: Dale Farnsworth <dale@farnsworth.org>
