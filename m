Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18309.33088.653225.116715@cargo.ozlabs.ibm.com>
Date: Thu, 10 Jan 2008 13:21:52 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: add phy-handle property for fec_mpc52xx
In-Reply-To: <1199893757.2978.73.camel@pmac.infradead.org>
References: <20080109140608.GA15673@aepfle.de> <4784E78C.40904@genesi-usa.com>
	<1199893757.2978.73.camel@pmac.infradead.org>
Cc: Olaf Hering <olaf@aepfle.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> It would be much better if the kernel would 'just work'. The ideal way
> of achieving that is for the firmware to be fixed -- but that's been
> promised for a long time now, and we just don't believe you any more. So
> working round it in the kernel seems to be the next best option.

Does the efika use a boot wrapper?  If so then putting the fixup in
the boot wrapper might be better.

Paul.
