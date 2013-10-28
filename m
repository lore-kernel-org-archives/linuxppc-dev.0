Return-Path: <michael@ellerman.id.au>
Date: Mon, 28 Oct 2013 12:09:58 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/3] powerpc: sync ppc64, ppc64e and pseries configs
Message-ID: <20131028010957.GA8331@concordia>
References: <20131022114450.296ae01d@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131022114450.296ae01d@kryten>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 22, 2013 at 11:44:50AM +1100, Anton Blanchard wrote:
> 
> Run savedefconfig over the ppc64, ppc64e and pseries config

> -CONFIG_EXPERIMENTAL=y

This went way.

> -CONFIG_EFI_PARTITION=y

This became default y.

> -CONFIG_HOTPLUG_CPU=y

This isn't going away, it's selected by pseries, so doesn't need to be
in the defconfig.

> -CONFIG_PPC_DENORMALISATION=y

This is default y if POWERNV, so I guess that's why it isn't needed.

cheers
