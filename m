Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17715.25272.777558.66052@cargo.ozlabs.ibm.com>
Date: Mon, 16 Oct 2006 20:45:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 1/4] powerpc: More bootwrapper reorg
In-Reply-To: <20061012013346.GB9143@mag.az.mvista.com>
References: <20061012013223.GA9143@mag.az.mvista.com>
	<20061012013346.GB9143@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer writes:

> More reorganization of the bootwrapper:
> - Add dtb section to zImage

Unfortunately it doesn't build for powermac because zImage.coff.lds is
missing the _dtb_start/end symbols.  Could you add the necessary bits
to zImage.coff.lds and resend?

Paul.
